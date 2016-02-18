

library( quantmod )
library( forecast )
library(caret)

sym <- "ONGC.NS"
# Get stock prices
ohlc <- getSymbols( sym, from="2010-01-01" , auto.assign=F)
#ohlc <- eval(parse(text = "ONGC.NS"))
# Compute the daily returns
returns <- diff( log( Cl( ohlc ) ) )
returns[returns < -0.2] <- NA
plot(returns)

#test.n = 1

#train_ind = seq_len(nrow(returns)-test.n)
returns.train = returns#[train_ind]
#returns.test = returns[-train_ind]

# Use only the last two years of returns
#gspcTail = as.ts( tail( gspcRets, 1000 ) )

# Fit the model

# 
# window.arima <- function(returns.train) {
#   arima.model=auto.arima(returns.train)
# #    plot(forecast(arima.model,h=test.n))
# #    points(1:length(returns.train),fitted(arima.model),type="l",col="green")
# #    summary(arima.model)
#   #forecast.arima = forecast(arima.model,h=test.n)$mean
#   #c(arima.model$var.coef, 1-prod(exp(forecast.arima)))
#   #log(prod(exp(forecast.arima)))
#   #coef(lm(USDZAR ~ ., data = as.data.frame(x))))
# }
out = rollapplyr(returns, 1000, auto.arima, by = 1, by.column = FALSE)
plot(out)
sum(abs(forecast.arima-returns.test))/sum(returns.test)

nnet.model<- nnetar(returns.train)
plot(forecast(nnet.model,h=test.n))
points(1:length(returns.train),fitted(nnet.model),type="l",col="green")
summary(nnet.model)
forecast.nnet = forecast(nnet.model,h=test.n)$mean


sum(abs(forecast.nnet-returns.test))/sum(returns.test)

#gspcArma = armaFit( formula=~arma(2,2), data=gspcTail )