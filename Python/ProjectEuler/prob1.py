
import sys
 
if __name__ == "__main__":
    if len(sys.argv)==1:
        print "Enter maximum value"
        sys.exit(0)
    num = []
    for i in xrange(int(sys.argv[1])):
        if (i%3==0) or (i%5==0): 
            num.append(i)
    print "Divisible by 3 or 5 values:" + str(num)
    print "sum:" + str(sum(num))


