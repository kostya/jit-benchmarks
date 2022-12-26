/* The Computer Language Benchmarks Game
   http://benchmarksgame.alioth.debian.org/

   Contributed by Jesse Millikan
   Modified by Matt Baker
*/

'use strict';

function frequency(seq, length){
  var freq = {},
      n = seq.length - length + 1,
      sub, i;

  for(i = 0; i < n; i++){
    sub = seq.substr(i, length);
    freq[sub] = (freq[sub] || 0) + 1;
  }

  return freq;
}


function sort(seq, length){
  var f = frequency(seq, length),
      keys = Object.keys(f), 
      n = seq.length - length + 1,
      i;

  keys.sort(function(a, b){ return f[b] - f[a]; });

  for(i in keys) {
    console.log(keys[i], (f[keys[i]] * 100 / n).toFixed(3));
  }
  
  console.log();
}


function find(seq, s){
  var f = frequency(seq, s.length);
  console.log((f[s] || 0) + "\t" + s);
}


function readSequence(f) {
  var lines = [],
      l;

  const readline = require('readline');
  const rl = readline.createInterface({ input: process.stdin });

  var body = false;
  
  rl.on('line', (line) => {
    if (line.substr(0, 6) == '>THREE') { body = true }
    if (body && line[0] !== '>') {
      lines.push(line);
    }
  });

  rl.on('close', () => {
    f(lines.join('').toUpperCase());
  });
}

function main(seq) {
  var start = new Date();

  sort(seq, 1);
  sort(seq, 2);

  find(seq, "GGT");
  find(seq, "GGTA");
  find(seq, "GGTATT");
  find(seq, "GGTATTTTAATT");
  find(seq, "GGTATTTTAATTTATAGT");  

  console.error("time(%d)", ((new Date()) - start) / 1000);
}

readSequence(function (seq) {
  const times = parseInt(process.argv[2]) || 1;

  console.error(`started\t${process.pid}`);
  for (let i = 0; i < times; i++) { main(seq); }
});

