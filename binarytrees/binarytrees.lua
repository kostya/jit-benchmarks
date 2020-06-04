-- The Computer Language Benchmarks Game
-- https://salsa.debian.org/benchmarksgame-team/benchmarksgame/
-- contributed by Mike Pall
-- *reset*

local function BottomUpTree(item, depth)
  if depth > 0 then
    depth = depth - 1
    local left, right = BottomUpTree(item * 2 - 1, depth), BottomUpTree(item * 2, depth)
    return { left, right, item }
  else
    return { }
  end
end

local function ItemCheck(tree)
  if tree[1] then
    return tree[3] + ItemCheck(tree[1]) - ItemCheck(tree[2])
  else
    return 0
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
    stretchdepth, ItemCheck(stretchtree)))
end

local longlivedtree = BottomUpTree(0, maxdepth)

for depth=mindepth,maxdepth,2 do
  local iterations = 2 ^ (maxdepth - depth + mindepth)
  local check = 0
  for i=1,iterations do
    check = check + ItemCheck(BottomUpTree(i, depth)) + ItemCheck(BottomUpTree(-i, depth))
  end
  io.write(string.format("%d\t trees of depth %d\t check: %d\n",
    iterations * 2, depth, check))
end

io.write(string.format("long lived tree of depth %d\t check: %d\n",
  maxdepth, ItemCheck(longlivedtree)))

io.stderr:write(string.format("time(%.9f)\n", os.clock() - start_time))
