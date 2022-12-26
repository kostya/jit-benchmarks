# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
# contributed by Dominique Wahli
# 2to3
# modified by Justin Peel

from sys import stdin,stdout
from re import sub, findall
import sys, time, os

def main(seq, clen, ilen):
    t = time.time()
    variants = (
          b'agggtaaa|tttaccct',
          b'[cgt]gggtaaa|tttaccc[acg]',
          b'a[act]ggtaaa|tttacc[agt]t',
          b'ag[act]gtaaa|tttac[agt]ct',
          b'agg[act]taaa|ttta[agt]cct',
          b'aggg[acg]aaa|ttt[cgt]ccct',
          b'agggt[cgt]aa|tt[acg]accct',
          b'agggta[cgt]a|t[acg]taccct',
          b'agggtaa[cgt]|[acg]ttaccct')
    for f in variants:
        write(f + b' ' +bytes(str(len(findall(f, seq))),encoding='latin1') + b'\n')

    subst = {
          b'B' : b'(c|g|t)', b'D' : b'(a|g|t)',   b'H' : b'(a|c|t)', b'K' : b'(g|t)',
          b'M' : b'(a|c)',   b'N' : b'(a|c|g|t)', b'R' : b'(a|g)',   b'S' : b'(c|g)',
          b'V' : b'(a|c|g)', b'W' : b'(a|t)',     b'Y' : b'(c|t)'}
    for f, r in subst.items():
        seq = sub(f, r, seq)
    write(b'\n')
    write(bytes(str(ilen),encoding='latin1') + b'\n')
    write(bytes(str(clen),encoding='latin1') + b'\n')
    write(bytes(str(len(seq)),encoding='latin1') + b'\n')
    sys.stderr.write("time({0})\n".format(time.time() - t))

if __name__ == '__main__':
    import sys

    seq = stdin.buffer.read()
    write = stdout.buffer.write
    ilen = len(seq)

    seq = sub(b'>.*\n|\n', b'', seq)
    clen = len(seq)

    times = int(sys.argv[1]) if len(sys.argv) > 1 else 1

    sys.stderr.write("started\t%d\n" % (os.getpid()))
    sys.stderr.flush()

    for i in range(0,times):
        main(seq, clen, ilen)

