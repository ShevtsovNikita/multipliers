import random

f = open('test_vectors.txt', 'w')

for i in range(0, 1024):
    a = random.randint(0, 2**32 - 1)
    b = random.randint(0, 2**32 - 1)
    c = a * b
    f.write("{:032b}_{:032b}_{:064b}\n".format(a, b, c))

f.close()
