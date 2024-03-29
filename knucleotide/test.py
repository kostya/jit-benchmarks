# The Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# submitted by Ian Osgood
# modified by Sokolov Yura
# modified by bearophile

from sys import stdin
import sys
import time, os

def gen_freq(seq, frame, frequences):
    ns = len(seq) + 1 - frame
    frequences.clear()
    for ii in range(0, ns):
        nucleo = seq[ii:ii + frame]
        if nucleo in frequences:
            frequences[nucleo] += 1
        else:
            frequences[nucleo] = 1
    return ns, frequences


def sort_seq(seq, length, frequences):
    n, frequences = gen_freq(seq, length, frequences)

    l = [(freq, seq) for seq, freq in frequences.items()]
    l.sort(reverse = True)

    print('\n'.join(["%s %.3f" % (st, 100.0*fr/n) for fr,st in l]))
    print("")


def find_seq(seq, s, frequences):
    n,t = gen_freq(seq, len(s), frequences)
    print("%d\t%s" % (t.get(s, 0), s))


def main(sequence):
    t = time.time()

    for nl in 1,2:
        sort_seq(sequence, nl, frequences)

    for se in "GGT GGTA GGTATT GGTATTTTAATT GGTATTTTAATTTATAGT".split():
        find_seq(sequence, se, frequences)

    sys.stderr.write("time({0})\n".format(time.time() - t))
    sys.stderr.flush()


times = int(sys.argv[1]) if len(sys.argv) > 1 else 1

frequences = {}
for line in stdin:
    if line[0:3] == ">TH":
        break

seq = []
for line in stdin:
    if line[0] in ">;":
        break
    seq.append( line[:-1] )
sequence = "".join(seq).upper()


sys.stderr.write("started\t%d\n" % (os.getpid()))
sys.stderr.flush()

for i in range(0,times):
    main(sequence)