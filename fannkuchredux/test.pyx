#    The Computer Language Benchmarks Game
#    http://shootout.alioth.debian.org/

#    contributed by Isaac Gouy
#    converted to Java by Oleg Mazurov
#    converted to Python by Buck Golemon
#    modified and cythonized by Justin Peel

from libc.stdlib cimport malloc
from sys import argv
import sys, time, os

cdef long fannkuch(long n):
    cdef long* perm1 = <long *>malloc(n*sizeof(long))
    cdef long* count = <long *>malloc(sizeof(long)*n)
    cdef long* perm = <long *>malloc(sizeof(long)*n)
    cdef long maxFlipsCount = 0
    cdef long permSign = 1
    cdef long checksum = 0
    cdef long k, kk, i, j, nm, tmp, r, flipsCount
    for i in xrange(0,n):
        perm1[i] = i
        count[i] = i
    nm = n - 1
    while 1:
        k = perm1[0]
        if k:
            for i in xrange(n):
                perm[i] = perm1[i]
            flipsCount = 1
            kk = perm[k]
            while kk:
                j = 0
                while j < k:
                    tmp = perm[j]
                    perm[j] = perm[k]
                    perm[k] = tmp
                    j += 1
                    k -= 1
                flipsCount += 1
                k = kk
                kk = perm[kk]
            if maxFlipsCount < flipsCount:
                maxFlipsCount = flipsCount
            if permSign:
                checksum += flipsCount
            else:
                checksum -= flipsCount

        # Use incremental change to generate another permutation
        if permSign:
            tmp = perm1[0]
            perm1[0] = perm1[1]
            perm1[1] = tmp
            permSign = 0
        else:
            tmp = perm1[1]
            perm1[1] = perm1[2]
            perm1[2] = tmp
            permSign = 1
            for r in xrange(2,n-1):
                if count[r]:
                    break
                count[r] = r
                tmp = perm1[0]
                for i in xrange(r + 1):
                     perm1[i] = perm1[i+1]
                perm1[r+1] = tmp
            else:
                r = nm
                if not count[r]:
                    print( checksum )
                    return maxFlipsCount
            count[r] -= 1

def main(n1):
    t = time.time()
    cdef long n = n1
    cdef long res = fannkuch(n)
    print( "Pfannkuchen(%i) = %i" % (n, res) )
    sys.stderr.write("time({0})\n".format(time.time() - t))

n = int(sys.argv[1]) if len(sys.argv) > 1 else 7
times = int(sys.argv[2]) if len(sys.argv) > 2 else 1

sys.stderr.write("started\t%d\n" % (os.getpid()))
sys.stderr.flush()

for i in range(0,times):
    main(n)    
