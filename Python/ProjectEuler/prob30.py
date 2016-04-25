final = []
for i in range(2,6*9**5):
    if i==sum([int(j)**5 for j in str(i)]):
        final.append(i)
print final
print sum(final)
