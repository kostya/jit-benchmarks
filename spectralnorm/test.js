// The Computer Language Benchmarks Game
// https://salsa.debian.org/benchmarksgame-team/benchmarksgame/
//
// contributed by Ian Osgood
// modified for Node.js by Isaac Gouy 

function A(i,j) {
  return 1/((i+j)*(i+j+1)/2+i+1);
}

function Au(u,v) {
  for (var i=0; i<u.length; ++i) {
    var t = 0;
    for (var j=0; j<u.length; ++j)
      t += A(i,j) * u[j];
    v[i] = t;
  }
}

function Atu(u,v) {
  for (var i=0; i<u.length; ++i) {
    var t = 0;
    for (var j=0; j<u.length; ++j)
      t += A(j,i) * u[j];
    v[i] = t;
  }
}

function AtAu(u,v,w) {
  Au(u,w);
  Atu(w,v);
}

function spectralnorm(n) {
  var i, u=[], v=[], w=[], vv=0, vBv=0;
  for (i=0; i<n; ++i) {
    u[i] = 1; v[i] = w[i] = 0; 
  }
  for (i=0; i<10; ++i) {
    AtAu(u,v,w);
    AtAu(v,u,w);
  }
  for (i=0; i<n; ++i) {
    vBv += u[i]*v[i];
    vv  += v[i]*v[i];
  }
  return Math.sqrt(vBv/vv);
}

function run(n) {
  start = new Date()
  console.log(spectralnorm(n).toFixed(9));
  console.error("time(%d)", ((new Date()) - start) / 1000);
}

const n = parseInt(process.argv[2]) || 1000;
const times = parseInt(process.argv[3]) || 1;

console.error(`started\t${process.pid}`);
for (let i = 0; i < times; i++) { run(n); }