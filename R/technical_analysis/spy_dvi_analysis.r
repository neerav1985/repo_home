require(quantmod)
source("dvi.analysis.r")

getSymbols("SPY", from="1900-01-01")
aa = dvi.analysis(Cl(SPY["/2009"]), lags=seq(1,8), normalize=T, file.path="dvi.median.png", func=mean)

bb = na.exclude(aa$raw.res$'1'$'0.6')
cc = as.numeric(na.exclude(aa$rets$"1"))

t.test(bb, mu=mean(cc), conf.level=0.99, alternative="less")

#  One Sample t-test
#
# data:  bb
# t = -2.9498, df = 415, p-value = 0.00168
# alternative hypothesis: true mean is less than 0.0002968406
# 99 percent confidence interval:
#           -Inf -2.223589e-05
# sample estimates:
#    mean of x 
# -0.001234948

# The above could be interpreted that the probability of obtaining a sample
# with this mean is very, very low.

res = 0
for(ii in 1:1000) {
  if(mean(sample(cc, size=NROW(bb)) < mean(bb))) {
    res = res + 1
  }
}
print(res)
# The result is consistently below 10, or less than 1%