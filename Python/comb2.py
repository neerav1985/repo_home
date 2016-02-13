###get nCr combinations with r=2

if __name__ == "__main__":
    a = ['A','B','C']
    out = []
    for i,el in enumerate(a):
        for j in range(i+1,len(a)):
            out += [[el, a[j]]]
    print out        
            
