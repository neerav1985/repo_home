import math
import sys
output = []
for num in range(2,int(sys.stdin.readline().strip())): 
    if all(num%i!=0 for i in range(2,int(math.sqrt(num))+1)):
        output.append(str(num))
print " ".join(output)    
