#include <iostream>
#include <vector>
#include <unordered_map>
#include <string>
#include <algorithm>
#include "time.h"
using namespace std;


unordered_map<string, int> hashcnt(const string &s, int k) {
  unordered_map<string, int> d;
  for (int i = 0; i < s.size() - k + 1; i++) {
    string q = s.substr(i, k);
    d[q] += 1;
  }
  return d;
}

void cnt(const string &s, string q) {
  unordered_map<string, int> d = hashcnt(s, q.size());
  printf("%d\t%s\n", d[q], q.c_str());
}

bool comp(const pair<string, int> &a, const pair<string, int> &b) {
  return a.second > b.second;
}
void freq(const string &s) {
  unordered_map<string, int> d = hashcnt(s, 1);
  vector<pair<string, int>> elems(d.begin(), d.end());
  sort(elems.begin(), elems.end(), comp);
  for (auto &k: elems) 
    printf("%s %6.3f\n", k.first.c_str(), (100.0 * k.second) / s.size());
  printf("\n");


  d = hashcnt(s, 2);
  elems = vector<pair<string, int>>(d.begin(), d.end());
  sort(elems.begin(), elems.end(), comp);
  for (auto &k: elems) 
    printf("%s %5.3f\n", k.first.c_str(), (100.0 * k.second) / (s.size()-1));
  printf("\n");
}

void process(const string &sq) {
  freq(sq);
  cnt(sq, "GGT");
  cnt(sq, "GGTA");
  cnt(sq, "GGTATT");
  cnt(sq, "GGTATTTTAATT");
  cnt(sq, "GGTATTTTAATTTATAGT");
}

int main(void) {
  clock_t t = clock();
  string line;
  while (getline(cin, line)) {
    if (line.substr(0, 6) == ">THREE") {
      string s;
      while (getline(cin, line)) {
        if (line[0] == '>') break;
        transform(line.begin(), line.end(), line.begin(), ::toupper);
        s += line;
      }
      process(s);
      break;
    }
  }
  fprintf(stderr, "time(%.2f)\n", (float)(clock() - t)/CLOCKS_PER_SEC);
  return 0;
}
