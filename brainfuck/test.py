import platform
import sys, time
import os

class Tape(object):
    def __init__(self):
        self.tape = [0]
        self.pos = 0
    def get(self):
        return self.tape[self.pos]
    def inc(self):
        self.tape[self.pos] += 1
    def dec(self):
        self.tape[self.pos] -= 1
    def advance(self):
        self.pos += 1
        if len(self.tape) <= self.pos:
            self.tape.append(0)
    def devance(self):
        if self.pos > 0:
            self.pos -= 1

class Program(object):
    def __init__(self, text):
        self.code = ""
        self.bracket_map = {}
        leftstack = []

        pc = 0
        for char in text:
            if char in ('[', ']', '<', '>', '+', '-', ',', '.'):
                self.code += char
                if char == '[':
                    leftstack.append(pc)
                elif char == ']' and len(leftstack) > 0:
                    left = leftstack.pop()
                    right = pc
                    self.bracket_map[left] = right
                    self.bracket_map[right] = left
                pc += 1

    def run(self):
        pc = 0
        tape = Tape()

        while pc < len(self.code):
            char = self.code[pc]
            if char == "+":
                tape.inc()
            elif char == "-":
                tape.dec()
            elif char == ">":
                tape.advance()
            elif char == "<":
                tape.devance()
            elif char == "[" and tape.get() == 0:
                pc = self.bracket_map[pc]
            elif char == "]" and tape.get() != 0:
                pc = self.bracket_map[pc]
            elif char == ".":
                sys.stdout.write(chr(tape.get()))
                sys.stdout.flush()
            pc += 1

def main(text):
    t = time.time()
    Program(text).run()
    sys.stderr.write("time({0})\n".format(time.time() - t))
    sys.stderr.flush()

import os
f = open(sys.argv[1], "r")
text = f.read()
times = int(sys.argv[2]) if len(sys.argv) > 2 else 1

sys.stderr.write("started\t%d\n" % (os.getpid()))
sys.stderr.flush()

for i in range(0,times):
    main(text)