
import sys
import numpy as np

def is_palindrome(x):
    for i in range(int(len(x)/2)):
        if x[i]!=x[-(i+1)]:
            return False
    return True

def is_palindrome2(x):
    return x == "".join(list(reversed(x)))

if __name__ == "__main__":
    if len(sys.argv)==1:
        print "Largest palindome of N-digit numbers. Enter N:"
        sys.exit(0)
    n = int(sys.argv[1]) -1
    palin = {}
    for i in xrange(10 ** n, 10 ** (n+1) ):
        for j in xrange(10 ** n, 10 ** (n+1) ):
            if is_palindrome2(str(i * j)):
                palin[(i,j) ] = i * j

    print "Palindromes:" + str(palin)
    print "Largest palindrome:" + str(max(palin.values()))


