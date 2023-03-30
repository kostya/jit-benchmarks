import sys, time, os

from python import os.getpid() -> int

class TreeNode():
    left: Optional[TreeNode]
    right: Optional[TreeNode]
    item: int

    def __init__(self, item):
        self.left = None
        self.right = None
        self.item = item

    def check(self):
        if not self.left:
            return self.item
        else:
            return self.item + self.left.check() - self.right.check()

def create(item, depth = 0) -> TreeNode:
    tn = TreeNode(item)
    if depth > 0:
        tn.left = create(2 * item - 1, depth - 1)
        tn.right = create(2 * item, depth - 1)        
    return tn

def main(max_depth):
    t = time.time()
    min_depth = 4
    stretch_depth = max_depth + 1

    print(f"stretch tree of depth {stretch_depth}\t check: {create(0, stretch_depth).check()}")

    long_lived_tree = create(0, max_depth)

    iterations = int(2**max_depth)
    for depth in range(min_depth, stretch_depth, 2):

        check = 0
        for i in range(1, int(iterations + 1)):
            check += create(i, depth).check() + create(-i, depth).check()

        print(f"{iterations * 2}\t trees of depth {depth}\t check: {check}")
        iterations = int(iterations / 4)

    print(f"long lived tree of depth {max_depth}\t check: {long_lived_tree.check()}")
    sys.stderr.write(f"time({time.time() - t})\n")
    sys.stderr.flush()



max_depth = int(sys.argv[1]) if len(sys.argv) > 1 else 10
times = int(sys.argv[2]) if len(sys.argv) > 2 else 1

sys.stderr.write(f"started\t{os.getpid()}\n")
sys.stderr.flush()

for i in range(0,times):
    main(max_depth)
