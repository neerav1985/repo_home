
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

def product(minx,maxx):
    return reduce(lambda x, y:x * y,range(minx, maxx+1)

def get_factors(num):
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
    return factors

if __name__ == "__main__":
    if len(sys.argv)==1:
        print "Enter the small and large number"
        sys.exit(0)
    step = int(sys.argv[2]) 
    more_primes( 2, step)
    ite +=1
    final_factors = []

    for i in xrange(minx,maxx+1):
       factors = []
       if product(minx

    print "Factors:" + str(factors)
    print "Largest Common mMultiple:" + str(reduce(lambda x,y: x*y,list(factors)))
