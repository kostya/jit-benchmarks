/* The Computer Language Benchmarks Game
   https://salsa.debian.org/benchmarksgame-team/benchmarksgame/

   contributed by Léo Sarrazin
   multi thread by Andrey Filatkin
   sequential by Isaac Gouy
*/

function mainThread() {
    start = new Date();
    const maxDepth = Math.max(6, parseInt(process.argv[2]));

    const stretchDepth = maxDepth + 1;
    const check = itemCheck(bottomUpTree(0, stretchDepth));
    console.log(`stretch tree of depth ${stretchDepth}\t check: ${check}`);

    const longLivedTree = bottomUpTree(0, maxDepth);

    for (let depth = 4; depth <= maxDepth; depth += 2) {
        const iterations = 1 << maxDepth - depth + 4;
        work(iterations, depth);
    }

    console.log(`long lived tree of depth ${maxDepth}\t check: ${itemCheck(longLivedTree)}`);
    console.error("time(%d)", ((new Date()) - start) / 1000);
}

function work(iterations, depth) {
    let check = 0;
    for (let i = 0; i < iterations; i++) {
        check += itemCheck(bottomUpTree(i, depth));
        check += itemCheck(bottomUpTree(-i, depth));
    }
    console.log(`${iterations * 2}\t trees of depth ${depth}\t check: ${check}`);
}

function TreeNode(item, left, right) {
    return {left, right, item};
}

function itemCheck(node) {
    if (node.left === null) {
        return node.item;
    }
    return node.item + itemCheck(node.left) - itemCheck(node.right);
}

function bottomUpTree(item, depth) {
    return depth > 0
        ? new TreeNode(item, bottomUpTree(item * 2 - 1, depth - 1), bottomUpTree(item * 2, depth - 1))
        : new TreeNode(item, null, null);
}

mainThread();
