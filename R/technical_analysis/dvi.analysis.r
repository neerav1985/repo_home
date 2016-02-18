require(quantmod)

prepare.indicator = function(close, indicator, roc.n, normalize=FALSE, func=mean) {
   rets = ROC(close, type="discrete", n=roc.n)
   
   if(normalize) {
      # Normalize the returns to daily
      rets = ((1 + rets) ^ (1/roc.n)) - 1
   }
   
   mm = merge(na.exclude(lag(indicator, k=roc.n)), na.exclude(rets), all=F)
   dd = as.numeric(mm[,1])
   
   # Map the indicator values into the tenth intervals
   ee = ceiling(dd*10)
   ee = ifelse(ee == 0, 1, ee)
   
   # Create the factors
   ff = factor(ee, labels=as.character(seq(0.1, 1, 0.1)))
   
   # Split the returns according to the factors
   gg = split(as.numeric(mm[,2]), ff)
   yy = sapply(gg, func)
   
   return(list(raw.res=gg, res=yy, rets=rets))
}

dvi.analysis = function(close, lags=c(5), normalize=FALSE, file.path, do.plot=TRUE, width=800, height=1200, func=mean) {
   # Redirect the plot if necessary
   if(do.plot && !missing(file.path)) {
      png(filename=file.path, width=width, height=height, units='px', pointsize=12, bg='white')
   }

   if(length(lags) %% 2 == 0) {
      par(mfrow=c(length(lags) / 2, 2))
   } else {
      par(mfrow=c(length(lags), 1))
   }

   ind = TTR:::DVI(close)[,3]
   res = list()
   raw.res = list()
   rets = list()

   for(ll in lags) {
      xx = prepare.indicator(close, ind, roc.n=ll, normalize=normalize, func=func)
      yy = xx$res
      
      barplot(
         yy,
         ylim=c(-max(abs(yy)), max(abs(yy))),
         col=ifelse(yy<0, "darkblue", "red"),
         main=paste(as.character(ll), "-day returns", sep=""),
         xlab="DVI level",
         ylab="Expected return")
      
      res[[as.character(ll)]] = xx$res
      raw.res[[as.character(ll)]] = xx$raw.res
      rets[[as.character(ll)]] = xx$rets
      # return(list(gg=gg, ff=ff, ee=ee, dd=dd))
   }
 
   # Restore the plot output
   if(do.plot && !missing(file.path)) {
      dev.off();
   }

   return(list(res=res, raw.res=raw.res, rets=rets))
}