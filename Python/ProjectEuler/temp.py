
import sys

if __name__ == "__main__":
    if len(sys.argv)==1:
        print "Enter maximum value"
        sys.exit(0)
    rng = range(1, int(sys.argv[1]) + 1 )
    while True:
        print rng
        if len(rng)==1: break
        if len(rng)%2 == 0:
            rng = rng[::2]
        else:
            rng = rng[::2]
            rng.insert(0,rng.pop())
