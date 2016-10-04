# Run install_packages.R
source("~/work/repo_home.git/R/port_optim/install_packages.R")
library(quantmod)
library(plyr)
library(PortfolioAnalytics)

symbols <- c("RELIANCE.NS","ONGC.NS","INFY.NS","TCS.NS","TECHM.NS","HEXAWARE.NS","COLPAL.NS","GODREJCP.NS")

#1
try(getSymbols(symbols)) 
symbols <- symbols[symbols %in% ls()]

#2
sym.list <- llply(symbols, get) 

#3
data <- xts()
for(i in seq_along(symbols)) {
  symbol <- symbols[i]
  data <- merge(data, get(symbol)[,paste(symbol, "Adjusted", sep=".")])
}
colnames(data) <- symbols
#returns <- diff(log(data))
returns <- na.locf(diff(log(na.locf(data))))
init.portfolio <- portfolio.spec(assets = colnames(returns))
print.default(init.portfolio)
init.portfolio <- add.constraint(portfolio = init.portfolio, type = "full_investment")
init.portfolio <- add.constraint(portfolio = init.portfolio, type = "long_only")
# Add objective for portfolio to minimize portfolio standard deviation
minSD.portfolio <- add.objective(portfolio=init.portfolio, 
                                 type="risk", 
                                 name="StdDev")

# Add objectives for portfolio to maximize mean per unit ES
meanES.portfolio <- add.objective(portfolio=init.portfolio, 
                                  type="return", 
                                  name="mean")

meanES.portfolio <- add.objective(portfolio=meanES.portfolio, 
                                  type="risk", 
                                  name="ES")
print(minSD.portfolio)
print(meanES.portfolio)

minSD.opt <- optimize.portfolio(R = returns, portfolio = minSD.portfolio, 
                                optimize_method = "ROI", trace = TRUE)
print(minSD.opt)

returns <- returns[returns[,1]<1]
meanES.opt <- optimize.portfolio(R = returns, portfolio = meanES.portfolio, 
                                optimize_method = "random", trace = TRUE)

print(meanES.opt)

install.packages("glmnet", repos = "http://cran.us.r-project.org")
library(glmnet)
cvfit <- cv.glmnet(as.matrix(returns[,colnames(returns)[colnames(returns) != 'RELIANCE.NS']]),
                           as.matrix(returns[,'RELIANCE.NS']))
plot(cvfit)
print(cvfit)
cvfit$lambda.min
coef(cvfit, s = "lambda.min")
