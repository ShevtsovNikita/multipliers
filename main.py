import random

mass = []
f = open('test_vectors.txt', 'w')

for i in range(0, 256):
    a = random.randint(0, 2**10 - 1)
    b = random.randint(0, 2**10 - 1)
    c = a * b
    f.write("{:032b}_{:032b}_{:064b} //{}_{}_{}\n".format(a, b, c, a, b, c))
print(mass)

f.close()
