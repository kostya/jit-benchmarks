-- The Computer Language Benchmarks Game
-- https://salsa.debian.org/benchmarksgame-team/benchmarksgame/
-- contributed by Mike Pall
-- *reset*

local function TreeNode(_item, _left, _right)
  local item = _item;
  local left = _left;
  local right = _right;

  local check = function()
    if left then
      return item + left.check() - right.check()
    else
      return item
    end
  end
  
  return {
    check = check;
  };  
end

local function BottomUpTree(item, depth)
  if depth > 0 then
    depth = depth - 1
    local left, right = BottomUpTree(item * 2 - 1, depth), BottomUpTree(item * 2, depth)
    return TreeNode(item, left, right)
  else
    return TreeNode(item, null, null)
  end
end

start_time = os.clock()

local N = tonumber(arg and arg[1]) or 0
local mindepth = 4
local maxdepth = mindepth + 2
if maxdepth < N then maxdepth = N end

do
  local stretchdepth = maxdepth + 1
  local stretchtree = BottomUpTree(0, stretchdepth)
  io.write(string.format("stretch tree of depth %d\t check: %d\n",
    stretchdepth, stretchtree.check()))
end

local longlivedtree = BottomUpTree(0, maxdepth)

for depth=mindepth,maxdepth,2 do
  local iterations = 2 ^ (maxdepth - depth + mindepth)
  local check = 0
  for i=1,iterations do
    check = check + BottomUpTree(i, depth).check() + BottomUpTree(-i, depth).check()
  end
  io.write(string.format("%d\t trees of depth %d\t check: %d\n",
    iterations * 2, depth, check))
end

io.write(string.format("long lived tree of depth %d\t check: %d\n",
  maxdepth, longlivedtree.check()))

io.stderr:write(string.format("time(%.9f)\n", os.clock() - start_time))
