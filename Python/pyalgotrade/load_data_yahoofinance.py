from pyalgotrade.tools import yahoofinance 
import sys
for i in range(2010,2017):
    yahoofinance.download_daily_bars(sys.argv[1], i, sys.argv[1] + '-' + str(i) + '.csv')
print 'Done..'
