/* The Computer Language Benchmarks Game
   https://salsa.debian.org/benchmarksgame-team/benchmarksgame/

   contributed by Denis Gribov
   based on C source code by Ledhug
   js BigInt replaced with gmplib by Andrey Filatkin
*/

const MPZ = require('mpzjs');

const n = +process.argv[2] || 10000;

const char0 = '0'.charCodeAt(0);
const charT = '\t'.charCodeAt(0);
const charN = '\n'.charCodeAt(0);
const charC = ':'.charCodeAt(0);

start = new Date();

let bufSize = (10 + 2 + n.toString().length + 1) * (n / 10);
for (let i = 10, ii = 10 ** (Math.log10(n) >>> 0); i < ii; i *= 10) {
    bufSize -= i - 1;
}

const buf = Buffer.allocUnsafe(bufSize);
let bufOffs = 0;

let i = 0;
let k = 0;
let k2 = 1;
const acc = MPZ(0);
const den = MPZ(1);
const num = MPZ(1);
const tmp = MPZ();
const d3 = MPZ();
const d4 = MPZ();

while (i < n) {
    k++;
    k2 += 2;

    MPZ.addMul(acc, num, 2);
    MPZ.mul(acc, acc, k2);
    MPZ.mul(den, den, k2);
    MPZ.mul(num, num, k);

    if (num.gt(acc)) {
        continue;
    }

    MPZ.mul(tmp, num, 3);
    MPZ.add(tmp, tmp, acc);
    MPZ.div(d3, tmp, den);

    MPZ.add(tmp, tmp, num);
    MPZ.div(d4, tmp, den);

    if (d3.ne(d4)) {
        continue;
    }

    const d = d3.toNumber();
    buf.writeInt8(d + char0, bufOffs++);
    i++;
    if (i % 10 === 0) {
        writeLineEnd(i);
    }

    MPZ.subMul(acc, den, d);
    MPZ.mul(acc, acc, 10);
    MPZ.mul(num, num, 10);
}

function writeLineEnd(i) {
    buf.writeInt8(charT, bufOffs++);
    buf.writeInt8(charC, bufOffs++);

    let str = i.toString();
    buf.write(str, bufOffs, bufOffs += str.length);

    buf.writeInt8(charN, bufOffs++);
}

process.stdout.write(buf);
console.error("time(%d)", ((new Date()) - start) / 1000);
