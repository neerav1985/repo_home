
import sys
 
if __name__ == "__main__":
    if len(sys.argv)==1:
        print "Enter maximum value"
        sys.exit(0)
    num = [1,2]
    even= [2]
    while num[-1] + num[-2] < int(sys.argv[1]):
        i = num[-1] + num[-2]
        num.append(i)
        if i%2 == 0:
            even.append(i)
    print "Fibonacci values:" + str(num)
    print "Even fibonacci values:" + str(even)
    print "sum:" + str(sum(even))


