# Writen by Attractive Chaos; distributed under the MIT license

import sys
import os, time
from python import os.getpid() -> int

def matmul(a, b):
    c = [[0.0] * len(b) for _ in range(len(b[0]))]
    for i in range(len(b[0])):
        for j in range(len(b)):
            c[i][j] = b[j][i]

    d = [[0.0] * len(b[0]) for _ in range(len(a))]

    for i in range(len(a)):
        for j in range(len(b[0])):
            s, ai, cj = 0.0, a[i], c[j]
            for k in range(len(b)):
                s += ai[k] * cj[k]
            d[i][j] = s
    return d

def build_matrix(n):
    t = 1.0 / n / n
    m = [[0.0] * n for _ in range(n)]
    for i in range(n):
        for j in range(n):
            m[i][j] = t * (i - j) * (i + j)
    return m

def main(n):
    t = time.time()

    a = build_matrix(n)
    b = build_matrix(n)

    d = matmul(a, b)
    print(f"{(d[n // 2][n // 2]):0.9f}")

    sys.stderr.write(f"time({time.time() - t})\n")
    sys.stderr.flush()

n = int(sys.argv[1]) if len(sys.argv) > 1 else 10
times = int(sys.argv[2]) if len(sys.argv) > 2 else 1

sys.stderr.write(f"started\t{os.getpid()}\n")
sys.stderr.flush()

for i in range(0,times):
    main(n)