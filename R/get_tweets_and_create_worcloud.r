library( quantmod )
library( forecast )
#install.packages("forecast")
# Get S&P 500
getSymbols( "^GSPC", from="2000-01-01" )

# Compute the daily returns
gspcRets = diff( log( Cl( GSPC ) ) )
y=auto.arima(gspcRets)
plot(forecast(y,h=30))
points(1:length(gspcRets),fitted(y),type="l",col="green")


library(dplyr)
library(broom)

df.h = data.frame( 
  hour     = 1:504,
  price    = runif(504, min = -10, max = 125),
  wind     = runif(504, min = 0, max = 2500),
  temp     = runif(504, min = - 10, max = 25)  
)

dfHour = df.h %>% group_by(hour) %>%
  do(fitHour = lm(price ~ wind + temp, data = .))
