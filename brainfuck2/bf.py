import platform
import sys, time
import os

INC = 1
MOVE = 2
LOOP = 3
PRINT = 4

class Op(object):
    def __init__(self, op, val):
        self.op = op
        self.val = val

class Tape(object):
    def __init__(self):
        self.tape = [0]
        self.pos = 0
    def get(self):
        return self.tape[self.pos]
    def inc(self, x):
        self.tape[self.pos] += x
    def move(self, x):
        self.pos += x
        while self.pos >= len(self.tape):
            self.tape.append(0)

def parse(iterator):
    res = []
    while True:
        try:
            # this check does not affect on performance
            if sys.version >= "3":
                c = iterator.__next__()
            else:
                c = iterator.next()
        except StopIteration:
            break

        if c == "+":
            res.append(Op(INC, 1))
        elif c == "-":
            res.append(Op(INC, -1))
        elif c == ">":
            res.append(Op(MOVE, 1))
        elif c == "<":
            res.append(Op(MOVE, -1))
        elif c == ".":
            res.append(Op(PRINT, 0))
        elif c == "[":
            res.append(Op(LOOP, parse(iterator)))
        elif c == "]":
            break

    return res

def _run(program, tape):
    for op in program:
        if op.op == INC: tape.inc(op.val)
        elif op.op == MOVE: tape.move(op.val)
        elif op.op == LOOP: 
            while tape.get() != 0:
                _run(op.val, tape)
        elif op.op == PRINT:
            sys.stdout.write(chr(tape.get()))
            sys.stdout.flush()

class Program(object):
    def __init__(self, code):
        self.ops = parse(iter(code))

    def run(self):
        _run(self.ops, Tape())

import os
t = time.time()
f = open(sys.argv[1], "r")
text = f.read()

Program(text).run()
sys.stderr.write("time({0})\n".format(time.time() - t))
