import sys, time
import os
from python import os.getpid() -> int

INC = 1
MOVE = 2
LOOP = 3
PRINT = 4

class Op(object):
    op: int
    int_val: int
    loop_val: list[Op]

    def __init__(self, op, int_val, loop_val = List[Op]()):
        self.op = op
        self.int_val = int_val
        self.loop_val = loop_val

class Tape(object):
    tape: list[int]
    pos: int

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
            c = next(iterator)
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
            res.append(Op(LOOP, 0, parse(iterator)))
        elif c == "]":
            break

    return res

def _run(program, tape):
    for op in program:
        if op.op == INC: tape.inc(op.int_val)
        elif op.op == MOVE: tape.move(op.int_val)
        elif op.op == LOOP: 
            while tape.get() != 0:
                _run(op.loop_val, tape)
        elif op.op == PRINT:
            sys.stdout.write(chr(tape.get()))
            sys.stdout.flush()

class Program(object):
    ops: list[Op]

    def __init__(self, code):
        self.ops = parse(iter(code))

    def run(self):
        _run(self.ops, Tape())

def main(text):
    t = time.time()
    Program(text).run()
    sys.stderr.write(f"time({time.time() - t})\n")
    sys.stderr.flush()

import os

f = open(sys.argv[1], "r")
text = f.read()
times = int(sys.argv[2]) if len(sys.argv) > 2 else 1

sys.stderr.write(f"started\t{os.getpid()}\n")
sys.stderr.flush()

for i in range(0,times):
    main(text)