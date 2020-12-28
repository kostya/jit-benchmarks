// The Computer Language Benchmarks Game
// http://benchmarksgame.alioth.debian.org/
//
// contributed by Jesse Millikan
// Base on the Ruby version by jose fco. gonzalez
// fixed by Matthew Wilson

var i = "", ilen, clen, j, q = [ /agggtaaa|tttaccct/ig,
  /[cgt]gggtaaa|tttaccc[acg]/ig, /a[act]ggtaaa|tttacc[agt]t/ig,
  /ag[act]gtaaa|tttac[agt]ct/ig, /agg[act]taaa|ttta[agt]cct/ig,
  /aggg[acg]aaa|ttt[cgt]ccct/ig, /agggt[cgt]aa|tt[acg]accct/ig,
  /agggta[cgt]a|t[acg]taccct/ig, /agggtaa[cgt]|[acg]ttaccct/ig],
  b = [ /B/g, '(c|g|t)', /D/g, '(a|g|t)', /H/g, '(a|c|t)', /K/g, '(g|t)',
  /M/g, '(a|c)', /N/g, '(a|c|g|t)', /R/g, '(a|g)', /S/g, '(c|g)',
  /V/g, '(a|c|g)', /W/g, '(a|t)', /Y/g, '(c|t)']

const readline = require('readline');
const rl = readline.createInterface({ input: process.stdin });
const times = parseInt(process.argv[2]) || 1;

rl.on('line', (line) => {
	i+=line+"\n";	
});

rl.on('close', () => {
	ilen = i.length

	i = i.replace(/^>.*\n|\n/mg, ''); clen = i.length

	console.error("started");

	for (let k = 0; k < times; k++) { 
		start = new Date();
		for(j = 0; j<q.length; ++j) console.log(q[j].source, (i.match(q[j]) || []).length)

		for(j = -1; j<b.length - 1;) i = i.replace(b[++j], b[++j])

		console.log(["", ilen, clen, i.length].join("\n"))
		console.error("time(%d)", ((new Date()) - start) / 1000);
  }

});

