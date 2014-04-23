
library(plyr)
library(lubridate)
library(reshape)
library(zoo)
library(forecast)

#Input data
startdate <- mdy("01-01-2013")
enddate   <- mdy("04-13-2014")
freq      <- "d" #daily
tickers   <- c("^NSEI","^GSPC")

#Get csv from Yahoo finance
url <- sprintf("http://ichart.finance.yahoo.com/table.csv?s=<ticker>&a=%d&b=%d&c=%d&d=%d&e=%d&f=%d&g=%s&ignore=.csv", 
             month(startdate)-1,
             day(startdate),
             year(startdate),
             month(enddate)-1,
             day(enddate),
             year(enddate),
             freq
             )

func      <- function(x)  {
  url = gsub("<ticker>",x,url) 
  print(url)
  read.csv(url)
}

#save data to a list of dataframe
list.df   <- apply(as.matrix(tickers),1,func)
data      <- Reduce(function(...) merge(...,by=c("Date"),all=T),list.df)
data      <- na.omit(data)

#rename columns
colnames(data)[-1] <- paste(unlist(lapply(tickers,FUN=function(x) rep(x,6))),colnames(list.df[[1]])[-1],sep=".")

adj.cls.idx  <- (i <- grep("Adj.Close", colnames(data)))
adj.close    <- cbind(data["Date"],data[adj.cls.idx])  

#log returns
n   <- nrow(adj.close)
ln.returns <- cbind(adj.close[-1,1],log(adj.close[-1,-1]/adj.close[-n,-1]))
colnames(ln.returns) <- c("Date",paste(tickers,"returns",sep="."))

#rollapply(ln.returns[,-1] , 20, FUN=sd, fill=NA, align='right')
#cor(ln.returns[-1])
#ln.returns.z <- zoo(ln.returns)

#monthly correlation
corr <- rollapply(zoo(ln.returns[,2:3],as.Date(ln.returns[,1])) , 22, FUN=function(x) cor(as.numeric(x[,1]),as.numeric(x[,2])), align='right',by.column=FALSE)

#ARIMA(1,0,1) gives the best fit
arima.fit<-arima(corr, order=c(1,0,1))
corr.for<-forecast(arima.fit, 10)

getFitFcast<-function(dn,fcast){ 
  
  en<-max(time(fcast$mean)) #extract the max date used in the forecast
  
  #Extract Source Data
  ds<-as.data.frame(window(dn,end=en))
  names(ds)<-'observed'
  ds$date<-as.Date(time(window(dn,end=en)), origin = "1970-01-01")
  
  #Extract the Fitted Values 
  dfit<-as.data.frame(fcast$fitted)
  dfit$date<-as.Date.numeric(as.numeric(time(fcast$fitted)), origin = "1970-01-01")
  names(dfit)[1]<-'fitted'
  
  ds<-merge(ds,dfit,all.x=T) #Merge fitted values with source and training data
  
  #Exract the Forecast values and confidence intervals
  dfcastn<-as.data.frame(fcast)
  dfcastn$date<-as.Date.numeric(as.numeric(row.names(dfcastn)), origin = "1970-01-01")
  names(dfcastn)<-c('forecast','lo80','hi80','lo95','hi95','date')
  print(head(dfcastn))
  ds.fcast<-merge(ds,dfcastn,all.x=T,all.y=T, by = "date") #final data.frame for use in ggplot
  return(ds.fcast)
  
}


ds.fcast<-getFitFcast(corr,corr.for)

#plotting
plt1<-ggplot(data=ds.fcast,aes(x=date,y=observed)) 
plt1<-plt1+geom_line(col='red')
plt1<-plt1+geom_line(aes(y=fitted),col='blue')
plt1<-plt1+geom_line(aes(y=forecast),colour='blue')+geom_ribbon(aes(ymin=lo80,ymax=hi80),alpha=.25)
plt1<-plt1+scale_x_date(name='',breaks='1 month',labels = date_format("%b/%y")) #,minor_breaks='1 month'
plt1<-plt1+scale_y_continuous(name='Corrlation')
plt1<-plt1+theme(axis.text.x=element_text(size=10))
plt1<-plt1+ggtitle("S&P500 and Nifty Correlation")

plt1

