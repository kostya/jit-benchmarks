-- The Computer Language Benchmarks Game
-- https://salsa.debian.org/benchmarksgame-team/benchmarksgame/
-- contributed by Mike Pall

local function A(i, j)
  local ij = i+j-1
  return 1.0 / (ij * (ij-1) * 0.5 + i)
end

local function Av(x, y, N)
  for i=1,N do
    local a = 0
    for j=1,N do a = a + x[j] * A(i, j) end
    y[i] = a
  end
end

local function Atv(x, y, N)
  for i=1,N do
    local a = 0
    for j=1,N do a = a + x[j] * A(j, i) end
    y[i] = a
  end
end

local function AtAv(x, y, t, N)
  Av(x, t, N)
  Atv(t, y, N)
end

local function run(N)
  start_time = os.clock()

  local u, v, t = {}, {}, {}
  for i=1,N do u[i] = 1 end

  for i=1,10 do AtAv(u, v, t, N) AtAv(v, u, t, N) end

  local vBv, vv = 0, 0
  for i=1,N do
    local ui, vi = u[i], v[i]
    vBv = vBv + ui*vi
    vv = vv + vi*vi
  end
  io.write(string.format("%0.9f\n", math.sqrt(vBv / vv)))

  io.stderr:write(string.format("time(%.9f)\n", os.clock() - start_time))
end

local N = tonumber(arg and arg[1]) or 1000
local times = tonumber(arg and arg[2]) or 1

io.stderr:write(string.format("started\t%d\n", require("posix.unistd").getpid()))

for i=1,times,1 do
  run(N)
end