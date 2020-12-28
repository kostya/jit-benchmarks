from libc.stdlib cimport malloc, free
import sys, time

cdef struct Node:
    Node *left
    Node *right
    int item

cdef Node *make_tree(int item, int depth):
    cdef Node *t = <Node*>malloc(sizeof(Node))
    t.item = item
    if depth:
        depth -= 1
        item <<= 1
        t.left = make_tree(item - 1, depth)
        t.right = make_tree(item, depth)
    else:
        t.left = NULL
        t.right = NULL
    return t

cdef int check_tree(Node* t):
    cdef int tmp
    if t.left:
        tmp = t.item + check_tree(t.left) - check_tree(t.right)
    else:
        tmp = t.item
    free(t)
    return tmp

def main(int n):
    t = time.time()

    # By definition, trees can't have cycles. However, Python's garbage
    # collector will do lots of wasteful tree traversals to try to collect 
    # circular references. Normal reference counting still happens. 
    #import gc
    #gc.disable()

    cdef int min_depth, max_depth, stretch_depth, depth
    min_depth = 4
    max_depth = max(min_depth + 2, n)
    stretch_depth = max_depth + 1
    
    cdef int i, iterations
    cdef int check

    print "stretch tree of depth %d\t check:" % stretch_depth, check_tree(make_tree(0, stretch_depth))

    long_lived_tree = make_tree(0, max_depth)

    iterations = 1 << max_depth
    for depth in xrange(min_depth, stretch_depth, 2):

        check = 0
        for i in xrange(1, iterations + 1):
            check += check_tree(make_tree(i, depth))
            check += check_tree(make_tree(-i, depth))

        print "%d\t trees of depth %d\t check:" % (iterations * 2, depth), check
        iterations >>= 2

    print "long lived tree of depth %d\t check:" % max_depth, check_tree(long_lived_tree)
    sys.stderr.write("time({0})\n".format(time.time() - t))
    sys.stderr.flush()

if __name__ == '__main__':
    import sys

    max_depth = int(sys.argv[1]) if len(sys.argv) > 1 else 10
    times = int(sys.argv[2]) if len(sys.argv) > 2 else 1

    sys.stderr.write("started")
    sys.stderr.flush()

    for i in range(0,times):
        main(max_depth)

