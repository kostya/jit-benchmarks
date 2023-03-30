# The Computer Language Benchmarks Game
# https://salsa.debian.org/benchmarksgame-team/benchmarksgame/
#
# Contributed by Sebastien Loisel
# Fixed by Isaac Gouy
# Sped up by Josh Goldfoot
# Dirtily sped up by Simon Descarpentries
# Used list comprehension by Vadim Zelenin
# 2to3

from math      import sqrt
from sys       import argv
import sys, time, os
from python import os.getpid() -> int


def eval_A(i, j):
    ij = i+j
    return 1.0 / (ij * (ij + 1) / 2 + i + 1)


def eval_A_times_u(u):
    local_eval_A = eval_A

    return [ sum([ local_eval_A(i, j) * u_j
                   for j, u_j in enumerate(u)
                 ]
                )
             for i in range(len(u))
           ]


def eval_At_times_u(u):
    local_eval_A = eval_A

    return [ sum([ local_eval_A(j, i) * u_j
                   for j, u_j in enumerate(u)
                 ]
                )
             for i in range(len(u))
           ]


def eval_AtA_times_u(u):
    return eval_At_times_u(eval_A_times_u(u))


def main(n):
    t = time.time()
    u = [1.0] * n
    local_eval_AtA_times_u = eval_AtA_times_u

    for dummy in range(10):
        v = local_eval_AtA_times_u(u)
        u = local_eval_AtA_times_u(v)

    vBv = vv = 0.0

    for ue, ve in zip(u, v):
        vBv += ue * ve
        vv  += ve * ve

    print(f"{sqrt(vBv/vv):0.9f}")
    sys.stderr.write(f"time({time.time() - t})\n")
    sys.stderr.flush()

n = int(sys.argv[1]) if len(sys.argv) > 1 else 1000
times = int(sys.argv[2]) if len(sys.argv) > 2 else 1

sys.stderr.write(f"started\t{os.getpid()}\n")
sys.stderr.flush()

for i in range(0,times):
    main(n)