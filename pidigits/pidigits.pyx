# The Computer Language Shootout
# http://shootout.alioth.debian.org/
#
#  contributed by Robert Bradshaw
#  based on the the C GNU gcc version #2
#

cdef extern from "gmp.h":
    ctypedef struct mpz_t:
        pass
    
    cdef void mpz_init(mpz_t)
    cdef void mpz_init_set_ui(mpz_t, unsigned int)
    cdef int mpz_cmp(mpz_t, mpz_t)
    cdef unsigned int mpz_get_ui(mpz_t)
    
    cdef void mpz_add(mpz_t, mpz_t, mpz_t)
    cdef void mpz_mul_ui(mpz_t, mpz_t, unsigned int)
    cdef void mpz_addmul_ui(mpz_t, mpz_t, unsigned int)
    cdef void mpz_submul_ui(mpz_t, mpz_t, unsigned int)    

    cdef void mpz_tdiv_q(mpz_t, mpz_t, mpz_t)
    

cdef mpz_t numer, accum, denom, tmp

cdef unsigned int extract_digit(unsigned int n):
    mpz_mul_ui(tmp, numer, n)
    mpz_add(tmp, tmp, accum)
    mpz_tdiv_q(tmp, tmp, denom)
    return mpz_get_ui(tmp)

cdef void next_term(unsigned int k):
    cdef unsigned int y2 = k*2 + 1
    mpz_addmul_ui(accum, numer, 2)
    mpz_mul_ui(accum, accum, y2)
    mpz_mul_ui(numer, numer, k)
    mpz_mul_ui(denom, denom, y2)

cdef void eliminate_digit(unsigned int d):
    mpz_submul_ui(accum, denom, d)
    mpz_mul_ui(accum, accum, 10)
    mpz_mul_ui(numer, numer, 10)

def pidigits(unsigned int n):
    cdef unsigned int d, i = 0, k = 0, m
    mpz_init(tmp);
    mpz_init_set_ui(numer, 1);
    mpz_init_set_ui(accum, 0);
    mpz_init_set_ui(denom, 1);
    
    line = b' '*10
    cdef char *buf = line

    while True:
  
        while True:
            k += 1
            next_term(k);
            if mpz_cmp(numer, accum) <= 0:
                d = extract_digit(3)
                if d == extract_digit(4):
                    break

        m = i % 10
        buf[m] = d + c'0'
        i += 1

        if m == 9:
            print "%s\t:%d" % (line.decode(), i)
        if i >= n:
            break
            
        eliminate_digit(d)

    if m != 9:
        print "%s%s\t:%s" % (line[:m+1].decode(), ' ' * (10-m), n)

def main(n):
    t = time.time()
    pidigits(n)
    sys.stderr.write("time({0})\n".format(time.time() - t))


if __name__ == '__main__':
    import sys, time

    n = int(sys.argv[1]) if len(sys.argv) > 1 else 100
    times = int(sys.argv[2]) if len(sys.argv) > 2 else 1

    sys.stderr.write("started")
    sys.stderr.flush()

    for i in range(0,times):
        main(n)
