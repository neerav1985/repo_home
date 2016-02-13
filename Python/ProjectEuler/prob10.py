
import sys
import numpy as np

primes = set([2])
def is_prime(x):
    global primes
    for i in set(list( primes ) + range(max(primes),int(np.sqrt(x)))):
        if x%i==0:
            return False
    return True

def more_primes(min_n, max_n):
    global primes
    for i in xrange(min_n,max_n):
        if is_prime(i):
            primes.add(i)
    print "max prime:" + str(max(primes))

if __name__ == "__main__":
    if len(sys.argv)==1:
        print "Enter the number for prime factors"
        sys.exit(0)
    num = long(sys.argv[1])
    more_primes( 2, num)
    print "Primes:" + str(primes)
    print "sum:" + str(sum(primes))


