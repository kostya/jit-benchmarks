-- The Computer Language Benchmarks Game
-- https://salsa.debian.org/benchmarksgame-team/benchmarksgame/
-- contributed by Mike Pall
-- *reset*

local function createTreeNode(_item, _left, _right)
  local item = _item;
  local left = _left;
  local right = _right;

  return {
    item = item,
    left = left,
    right = right,
  };
end

local checkTreeNode

checkTreeNode = function(branch)
   if branch.left then
     return branch.item + checkTreeNode(branch.left) - checkTreeNode(branch.right)
   else
     return branch.item
   end
end

local function BottomUpTree(item, depth)
  if depth > 0 then
    depth = depth - 1
    local left, right = BottomUpTree(item * 2 - 1, depth), BottomUpTree(item * 2, depth)
    return createTreeNode(item, left, right)
  else
    return createTreeNode(item, null, null)
  end
end

local function run(N)
  start_time = os.clock()

  local mindepth = 4
  local maxdepth = mindepth + 2
  if maxdepth < N then maxdepth = N end

  do
    local stretchdepth = maxdepth + 1
    local stretchtree = BottomUpTree(0, stretchdepth)
    io.write(string.format("stretch tree of depth %d\t check: %d\n",
      stretchdepth, checkTreeNode(stretchtree)))
  end

  local longlivedtree = BottomUpTree(0, maxdepth)

  for depth=mindepth,maxdepth,2 do
    local iterations = 2 ^ (maxdepth - depth + mindepth)
    local check = 0
    for i=1,iterations do
      check = check + checkTreeNode(BottomUpTree(i, depth)) + checkTreeNode(BottomUpTree(-i, depth))
    end
    io.write(string.format("%d\t trees of depth %d\t check: %d\n",
      iterations * 2, depth, check))
  end

  io.write(string.format("long lived tree of depth %d\t check: %d\n",
    maxdepth, checkTreeNode(longlivedtree)))

  io.stderr:write(string.format("time(%.9f)\n", os.clock() - start_time))
end

local N = tonumber(arg and arg[1]) or 10
local times = tonumber(arg and arg[2]) or 1

io.stderr:write("started")

for i=1,times,1 do
  run(N)
end
