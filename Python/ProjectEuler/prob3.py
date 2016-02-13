
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
    step = 100
    ite = 1
    more_primes( 2, ite * step)
    ite +=1
    factors = set()
    while True:
        for i in primes:
            if num%i==0:
                factors.add(i)
                num/=i
            if num==1:
                break
        if num==1 :
            print num
            break
        if is_prime(num):
            print num
            factors.add(num)
            break
        if num > max(primes):
            print "current num:" + str(num)
            more_primes((ite-1) * step, ite * step)
            ite +=1

    print "Factors:" + str(factors)
    print "Largest Prime Factor:" + str(max(factors))


