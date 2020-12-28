# Writen by Attractive Chaos; distributed under the MIT license

import array
import platform
import sys
import os, time
from libc.stdlib cimport malloc

cdef double *matmul(double *a, double *b, int n):
    cdef int i, j, k
    cdef double s
    cdef double* ai, *cj

    cdef double* c = <double *> malloc(n*n*sizeof(double))
    for i in range(n):
        for j in range(n):
            c[i * n + j] = b[j * n + i]

    cdef double* d = <double *> malloc(n*n*sizeof(double))

    for i in range(n):
        for j in range(n):
            s = 0.0
            ai = a + i * n
            cj = c + j * n
            for k in range(n):
                s += ai[k] * cj[k]
            d[i * n + j] = s
    return d

cdef double *build_matrix(int n):
    cdef double* tmp = <double *> malloc(n*n*sizeof(double))
    t = 1.0 / n / n
    for i in range(n):
        for j in range(n):
            tmp[i * n + j] = t * (i - j) * (i + j)
    return tmp

def main(n1):
    cdef int n = n1
    t = time.time()

    cdef double *a = build_matrix(n)
    cdef double *b = build_matrix(n)

    cdef double *d = matmul(a, b, n)
    print("%.9f" % (d[(n // 2) * n  + n // 2]))

    sys.stderr.write("time({0})\n".format(time.time() - t))
    sys.stderr.flush()

if __name__ == "__main__":
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 10
    times = int(sys.argv[2]) if len(sys.argv) > 2 else 1

    sys.stderr.write("started")
    sys.stderr.flush()

    for i in range(0,times):
        main(n)    
