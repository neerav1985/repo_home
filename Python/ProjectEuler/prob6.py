
import sys
import numpy as np
import numpy as np

if __name__ == "__main__":
    if len(sys.argv)==1:
        print "Largest palindome of N-digit numbers. Enter N:"
        sys.exit(0)
    n=int(sys.argv[1])
    a=np.arange(1,n+1)
    out = sum(a)**2 - sum(a**2)
    print "Diff of squared sum and sums of squares:" + str(out)


