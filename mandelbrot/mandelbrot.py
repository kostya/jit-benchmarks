#!/usr/bin/python3

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#     * Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#
#     * Neither the name of "The Computer Language Benchmarks Game" nor the
#     name of "The Computer Language Shootout Benchmarks" nor the names of
#     its contributors may be used to endorse or promote products derived
#     from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

import sys, time

def main(n):
	t = time.time()
	w, h = n, n
	bit_num = 0
	byte_acc = 0
	Iter = 50
	Limit = 2.0

	sys.stdout.write("P4\n%d %d\n" % (n, n))

	buf = []
	for y in range(h):
		for x in range(w):
			Zr, Zi, Tr, Ti = 0.0, 0.0, 0.0, 0.0
			Cr = (2.0*x/w - 1.5)
			Ci = (2.0*y/h - 1.0)

			i = 0
			while i < Iter and (Tr+Ti <= Limit*Limit):
				Zi = 2*Zr*Zi + Ci
				Zr = Tr - Ti + Cr
				Tr = Zr * Zr
				Ti = Zi * Zi
				i += 1

			byte_acc <<= 1
			if Tr+Ti <= Limit*Limit:
				byte_acc |= 0x01

			bit_num += 1

			if bit_num == 8:
				buf.append(byte_acc)
				byte_acc = 0
				bit_num = 0
			elif x == w-1:
				byte_acc <<= 8-n%8
				buf.append(byte_acc)
				byte_acc = 0
				bit_num = 0

	if sys.version_info.major == 2:
		sys.stdout.write(bytearray(buf))
	else:
		sys.stdout.flush()
		sys.stdout.buffer.write(bytes(buf))
		sys.stdout.flush()
	sys.stderr.write("time({0})\n".format(time.time() - t))
	sys.stderr.flush()

if __name__=='__main__':
  n = int(sys.argv[1]) if len(sys.argv) > 1 else 100
  times = int(sys.argv[2]) if len(sys.argv) > 2 else 1

  sys.stderr.write("started")
  sys.stderr.flush()

  for i in range(0,times):
      main(n)
