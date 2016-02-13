
import sys
import numpy as np

primes = [2]
def is_prime(x):
    global primes
    ll = set( primes  + range(max(primes),int(np.sqrt(x))))
    for i in ll:
        if x%i==0:
            return False
    return True

if __name__ == "__main__":
    if len(sys.argv)==1:
        print "Get nth prime, enter n"
        sys.exit(0)
    n = int(sys.argv[1])
    i =3
    while len(primes)<n:
        if is_prime(i):
            primes.append(i)
        i += 2

    print "primes:" + str(primes)
    print "nth prime:" + str(primes[-1])
