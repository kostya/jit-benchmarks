<?php

/* The Computer Language Benchmarks Game
   https://salsa.debian.org/benchmarksgame-team/benchmarksgame/

   contributed by Peter Baltruschat
   modified by Levi Cameron
   *reset*
*/

class Node {
  public $item;
  public $l;
  public $r;
}

function bottomUpTree($item, $depth)
{
   $node = new Node();
   if (!$depth) {
     $node->item = 0;
     return $node;
   }
   $depth--;
   $node->item = $item;
   $node->l = bottomUpTree(2 * $item - 1, $depth);
   $node->r = bottomUpTree(2 * $item, $depth);
   return $node;
}

function itemCheck($treeNode) { 
   return $treeNode->item
      + ($treeNode->l->l === null ? 1 : itemCheck($treeNode->l))
      - ($treeNode->r->l === null ? 1 : itemCheck($treeNode->r));
}

function run($n) { 
  $start = microtime(true);
  $minDepth = 4;

  $maxDepth = max($minDepth + 2, $n);
  $stretchDepth = $maxDepth + 1;

  $stretchTree = bottomUpTree(0, $stretchDepth);
  printf("stretch tree of depth %d\t check: %d\n", $stretchDepth, itemCheck($stretchTree));
  unset($stretchTree);

  $longLivedTree = bottomUpTree(0, $maxDepth);

  $iterations = 1 << ($maxDepth);
  do
  {
     $check = 0;
     for($i = 1; $i <= $iterations; ++$i)
     {
        $t = bottomUpTree($i, $minDepth);
        $check += itemCheck($t);

        $t = bottomUpTree(-$i, $minDepth);
        $check += itemCheck($t);

        unset($t);
     }
     
     printf("%d\t trees of depth %d\t check: %d\n", $iterations * 2, $minDepth, $check);
     
     $minDepth += 2;
     $iterations >>= 2;
  }
  while($minDepth <= $maxDepth);

  printf("long lived tree of depth %d\t check: %d\n", $maxDepth, itemCheck($longLivedTree));
  fprintf(STDERR, "time(%.9f)\n", microtime(true) - $start);
}

$n = ($argc >= 2) ? $argv[1] : 10;
$times = ($argc == 3) ? $argv[2] : 1;

fprintf(STDERR, "started\n");

for($i = 1; $i <= $times; ++$i) {
  run($n);
}


?>
