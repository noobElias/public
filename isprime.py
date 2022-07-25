def isprime(n):
    if n<=1:
        return False
    if n<=3:
        return True
    if n%2==0 or n%3==0:
        return False

    def my_range(i, n, step):
        while i*i <= n:
            yield i
            i += step

    for i in my_range(5, n, 6):
        if (n%i==0) or (n%(i+2)==0):
            return False

    return True


finarr = []

for i in range (0,1000000):
    if isprime(i):
        finarr.append(i)


n = len(finarr)
print(n)
