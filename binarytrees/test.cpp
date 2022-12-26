// The Computer Language Benchmarks Game
// http://benchmarksgame.alioth.debian.org/

// Contributed by Akzhan Abdulin.
// Based on the Java program from Heikki Salokanto, Chandra Sekar, Mike Krüger.

#include <algorithm>
#include <iostream>
#include <memory>
#include <sstream>
#include "time.h"
#include <unistd.h>

using namespace std;

class TreeNode {
  int item;
  unique_ptr<TreeNode> left;
  unique_ptr<TreeNode> right;

public:
  TreeNode(int anItem, int depth) : item(anItem) {
    if (depth > 0) {
      left = std::unique_ptr<TreeNode>(new TreeNode(2 * item - 1, depth - 1));
      right = std::unique_ptr<TreeNode>(new TreeNode(2 * item, depth - 1));
    }
  }

  int check() {
    if (left == nullptr) {
      return item;
    }
    return left->check() - right->check() + item;
  }

  static unique_ptr<TreeNode> create(int item, int depth) {
    return std::unique_ptr<TreeNode>(new TreeNode(item, depth - 1));
  }
};

void run(int n) {
  clock_t t = clock();

  auto min_depth = 4;
  auto max_depth = max(min_depth + 2, n);

  int stretch_depth = max_depth + 1;

  auto stretch_tree = TreeNode::create(0, stretch_depth);
  auto check = stretch_tree->check();
  cout << "stretch tree of depth " << (max_depth + 1) << "\t check: " << check
       << endl;

  auto long_lived_tree = TreeNode::create(0, max_depth);

  for (auto depth = min_depth; depth <= max_depth; depth += 2) {
    auto iterations = 1 << (max_depth - depth + min_depth);
    auto check = 0;

    for (auto i = 1; i <= iterations; i++) {
      check += TreeNode::create(i, depth)->check();
      check += TreeNode::create(-i, depth)->check();
    }
    cout << (iterations << 1) << "\t trees of depth " << depth
         << "\t check: " << check << endl;
  }

  cout << "long lived tree of depth " << max_depth
       << "\t check: " << long_lived_tree->check() << endl;

  fprintf(stderr, "time(%.2f)\n", (float)(clock() - t)/CLOCKS_PER_SEC);
}

int main(int argc, char *argv[]) {
  auto n = 10;
  if (argc > 1) { istringstream(argv[1]) >> n; }
  
  auto times = 1;
  if (argc > 2) { istringstream(argv[2]) >> times; }

  fprintf(stderr, "started\t%d\n", getpid());

  for (auto i = 0; i < times; i++) { run(n); }

  return 0;
}
