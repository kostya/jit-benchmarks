# The Computer Language Benchmarks Game
# http://benchmarksgame.alioth.debian.org/
#
# submitted by Ian Osgood
# modified by Sokolov Yura
# modified by bearophile
# 2to3

from sys import stdin
import sys, time, os


def gen_freq(seq, int frame, frequences):
    cdef int ns, ii

    ns = len(seq) + 1 - frame
    frequences.clear()
    for ii in range(ns):
        nucleo = seq[ii:ii + frame]
        if nucleo in frequences:
            frequences[nucleo] += 1
        else:
            frequences[nucleo] = 1
    return ns, frequences


def sort_seq(seq, int length, frequences):
    cdef int n
    cdef float fr

    n, frequences = gen_freq(seq, length, frequences)

    l = sorted(list(frequences.items()), reverse=True, key=lambda seq_freq: (seq_freq[1], seq_freq[0]))

    print('\n'.join("%s %.3f" % (st, 100.0*fr/n) for st, fr in l))
    print("")


def find_seq(seq, s, frequences):
    n, t = gen_freq(seq, len(s), frequences)
    print("%d\t%s" % (t.get(s, 0), s))


def main(sequence):
    t = time.time()
    cdef int nl

    frequences = {}

    for nl in 1, 2:
        sort_seq(sequence, nl, frequences)

    for se in "GGT GGTA GGTATT GGTATTTTAATT GGTATTTTAATTTATAGT".split():
        find_seq(sequence, se, frequences)

    sys.stderr.write("time({0})\n".format(time.time() - t))

for line in stdin:
    if line[0:3] == ">TH":
        break

seq = []
for line in stdin:
    if line[0] in ">;":
        break
    seq.append(line[:-1])
sequence = "".join(seq).upper()

times = int(sys.argv[1]) if len(sys.argv) > 1 else 1

sys.stderr.write("started\t%d\n" % (os.getpid()))
sys.stderr.flush()

for i in range(0,times):
    main(sequence)
