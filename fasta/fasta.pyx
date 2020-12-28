# The Computer Language Benchmarks Game
# http://benchmarksgame.alioth.debian.org/
#
# modified by Ian Osgood
# modified again by Heinrich Acker
# modified by Justin Peel
# 2to3

import sys, bisect

alu = (
   'GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG'
   'GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA'
   'CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT'
   'ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA'
   'GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG'
   'AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC'
   'AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA')

iub = list(zip('acgtBDHKMNRSVWY', [0.27, 0.12, 0.12, 0.27] + [0.02]*11))

homosapiens = [
    ('a', 0.3029549426680),
    ('c', 0.1979883004921),
    ('g', 0.1975473066391),
    ('t', 0.3015094502008),
]


def genRandom(int ia = 3877, int ic = 29573, int im = 139968):
    cdef int seed
    cdef float imf

    seed = 42
    imf = float(im)
    while 1:
        seed = (seed * ia + ic) % im
        yield seed / imf

Random = genRandom()

def makeCumulative(table):
    cdef float prob, p

    P = []
    C = []
    prob = 0.
    for char, p in table:
        prob += p
        P += [prob]
        C += [char]
    return (P, C)

def repeatFasta(src, int n):
    cdef int width, r, j, i

    width = 60
    r = len(src)
    s = src + src + src[:n % r]
    for j in range(n // width):
        i = j*width % r
        print(s[i:i+width])
    if n % width:
        print(s[-(n % width):])

def randomFasta(table, int n):
    cdef int width, i, j

    width = 60
    r = range(width)
    gR = Random.__next__
    bb = bisect.bisect
    jn = ''.join
    probs, chars = makeCumulative(table)
    for j in range(n // width):
        x = jn([chars[bb(probs, gR())] for i in r])
        print(x)
    if n % width:
        print(jn([chars[bb(probs, gR())] for i in range(n % width)]))

def main(n1):
    t = time.time()
    cdef int n = n1

    print('>ONE Homo sapiens alu')
    repeatFasta(alu, n*2)

    print('>TWO IUB ambiguity codes')
    randomFasta(iub, n*3)

    print('>THREE Homo sapiens frequency')
    randomFasta(homosapiens, n*5)
    sys.stderr.write("time({0})\n".format(time.time() - t))
    sys.stderr.flush()

import sys, time
n = int(sys.argv[1]) if len(sys.argv) > 1 else 10
times = int(sys.argv[2]) if len(sys.argv) > 2 else 1

sys.stderr.write("started")
sys.stderr.flush()

for i in range(0,times):
    main(n)
