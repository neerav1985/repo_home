import itertools
from pyalgotrade.barfeed import yahoofeed
from pyalgotrade.optimizer import server
import sys

def parameters_generator():
    entrySMA = range(50, 150)#, 251)
    exitSMA = range(5, 16)
    rsiPeriod = range(5, 11)
    overBoughtThreshold = range(85, 96)
    overSoldThreshold = range(5, 16)
    return itertools.product(entrySMA, exitSMA, rsiPeriod, overBoughtThreshold, overSoldThreshold)

# The if __name__ == '__main__' part is necessary if running on Windows.
if __name__ == '__main__':
    # Load the feed from the CSV files.
    print sys.argv[1]
    feed = yahoofeed.Feed()
     
    for i in range(2010,2017):
        print str(i)
        feed.addBarsFromCSV(sys.argv[1], sys.argv[1] + "-" + str(i) + ".csv")

    # Run the server.
    server.serve(feed, parameters_generator(), "localhost", 5000)
