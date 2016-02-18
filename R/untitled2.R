install.packages("survrec")
library(survrec)

data(MMC)
fit<-mlefrailty.fit(Survr(MMC$id,MMC$time,MMC$event))
fit
plot(fit)
# compare with pena-straderman-hollander
fit<-psh.fit(Survr(MMC$id,MMC$time,MMC$event))
fit
lines(fit,lty=2)
# and with wang-chang
fit<-wc.fit(Survr(MMC$id,MMC$time,MMC$event))
fit
lines(fit,lty=3)
