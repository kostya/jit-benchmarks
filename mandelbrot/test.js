function mandelbrot(size) {
  start = new Date();
  const buf = Buffer.alloc(size * size);

  var y = 0, byte_acc = 0, bit_num = 0, acc = 0;
  while (y < size) {
    const ci = (2.0*y/size)-1.0;
    var x = 0;
    while (x < size) {
      var zrzr = 0.0, zr = 0.0, zizi = 0.0, zi = 0.0, cr = (2.0*x/size)-1.5, _escape = 1;

      var z = 0;
      while (z < 50) {
        var tr = zrzr - zizi + cr, ti = 2.0*zr*zi + ci, zr = tr, zi = ti,
          zrzr = zr*zr, zizi = zi*zi;
        if (zrzr+zizi > 4.0) {
          _escape = 0;
          break;
        }
        z += 1;
      }

      byte_acc = (byte_acc << 1) | _escape;
      bit_num += 1;

      if (bit_num == 8) {
        buf[acc] = byte_acc;
        acc += 1;
        byte_acc = 0;
        bit_num = 0;
      } else if (x == size - 1) {
        byte_acc <<= (8 - bit_num);
        buf[acc] = byte_acc;
        acc += 1;
        byte_acc = 0;
        bit_num = 0
      }

      x += 1;
    }
    y += 1;
  }
  console.log("P4\n%d %d", size, size);
  process.stdout.write(buf.toString('utf-8'));
  console.error("time(%d)", ((new Date()) - start) / 1000);
}

const n = parseInt(process.argv[2]) || 100;
const times = parseInt(process.argv[3]) || 1;

console.error(`started\t${process.pid}`);
for (let i = 0; i < times; i++) { mandelbrot(n); }