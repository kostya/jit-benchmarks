# The Computer Language Benchmarks Game
# http://benchmarksgame.alioth.debian.org/
#
# contributed by Jacob Lee, Steven Bethard, et al
# 2to3, fixed by Daniele Varrazzo
# modified by Daniel Nanz

import sys, time, string, os


def show(seq, table=string.maketrans(b'ACBDGHKMNSRUTWVYacbdghkmnsrutwvy',
                                    b'TGVHCDMKNSYAAWBRTGVHCDMKNSYAAWBR'),
         write=sys.stdout.write, nl=b'\n'):
    
    [header, s] = seq.split(nl, 1)
    s = s.translate(table, nl)[: : -1]
    
    write(b'>' + header + nl)
    for i in range(0, len(s), 60):
        write(s[i : i + 60] + nl)



def main():
    t = time.time()

    # sys.stdin = sys.stdin.detach()
    seqs = b''.join([line for line in sys.stdin]).split(b'>')[1 : ]
    
    for seq in seqs:
        show(seq)        

    sys.stderr.write("time({0})\n".format(time.time() - t))
    sys.stdout.flush()

sys.stderr.write("started\t%d\n" % (os.getpid()))
sys.stderr.flush()
main()

