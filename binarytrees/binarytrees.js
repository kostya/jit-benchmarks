/* The Computer Language Benchmarks Game
   https://salsa.debian.org/benchmarksgame-team/benchmarksgame/

   contributed by Léo Sarrazin
   multi thread by Andrey Filatkin
   sequential by Isaac Gouy
*/

function TreeNode(item, left, right) {
  this.item = item;
  this.left = left;
  this.right = right;

  this.check = function() {
    if (this.left === null) return this.item;
    return this.item + this.left.check() - this.right.check();
  }
}

function bottomUpTree(item, depth) {
    return depth > 0
        ? new TreeNode(item, bottomUpTree(item * 2 - 1, depth - 1), bottomUpTree(item * 2, depth - 1))
        : new TreeNode(item, null, null);
}

function mainThread() {
    start = new Date();
    const maxDepth = Math.max(6, parseInt(process.argv[2]));

    const stretchDepth = maxDepth + 1;
    const check = bottomUpTree(0, stretchDepth).check();
    console.log(`stretch tree of depth ${stretchDepth}\t check: ${check}`);

    const longLivedTree = bottomUpTree(0, maxDepth);

    for (let depth = 4; depth <= maxDepth; depth += 2) {
        const iterations = 1 << maxDepth - depth + 4;
        work(iterations, depth);
    }

    console.log(`long lived tree of depth ${maxDepth}\t check: ${longLivedTree.check()}`);
    console.error("time(%d)", ((new Date()) - start) / 1000);
}

function work(iterations, depth) {
    let check = 0;
    for (let i = 0; i < iterations; i++) {
        check += bottomUpTree(i, depth).check();
        check += bottomUpTree(-i, depth).check();
    }
    console.log(`${iterations * 2}\t trees of depth ${depth}\t check: ${check}`);
}

mainThread();

