def factorial(n):
    if n <=1:
        return 1
    else:
        return n*factorial(n-1)

print reduce(lambda x,y: int(x) + int(y),str(factorial(100)))
