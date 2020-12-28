#The Great Computer Language Shootout
#http://shootout.alioth.debian.org/
#contributed by Dominique Wahli

from sys import stdin
from re import sub, finditer
import sys, time

seq = stdin.read()
ilen = len(seq)

seq = sub('(>.*\n)|(\n)', '', seq)
clen = len(seq)

def main(seq, clen, ilen):
  t = time.time()

  variants = (
        'agggtaaa|tttaccct',
        '[cgt]gggtaaa|tttaccc[acg]',
        'a[act]ggtaaa|tttacc[agt]t',
        'ag[act]gtaaa|tttac[agt]ct',
        'agg[act]taaa|ttta[agt]cct',
        'aggg[acg]aaa|ttt[cgt]ccct',
        'agggt[cgt]aa|tt[acg]accct',
        'agggta[cgt]a|t[acg]taccct',
        'agggtaa[cgt]|[acg]ttaccct')
  for f in variants:
      print("{0} {1}".format(f, len(list(finditer(f, seq)))))

  subst = {
        'B' : '(c|g|t)', 'D' : '(a|g|t)',   'H' : '(a|c|t)', 'K' : '(g|t)',
        'M' : '(a|c)',   'N' : '(a|c|g|t)', 'R' : '(a|g)',   'S' : '(c|g)',
        'V' : '(a|c|g)', 'W' : '(a|t)',     'Y' : '(c|t)'}
  
  for f, r in subst.items():
      seq = sub(f, r, seq)

  print("")
  print(ilen)
  print(clen)
  print(len(seq))

  sys.stderr.write("time({0})\n".format(time.time() - t))


times = int(sys.argv[1]) if len(sys.argv) > 1 else 1

sys.stderr.write("started")
sys.stderr.flush()

for i in range(0,times):
    main(seq, clen, ilen)
