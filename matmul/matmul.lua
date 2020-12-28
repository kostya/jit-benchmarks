local function matgen(n)
    local tmp = 1.0 / n / n;
    local m = {};
    for i = 1, n do
        local a = {};
        for j = 1, n do
            a[j] = tmp * (i - j) * (i + j - 2);
        end
        m[i] = a;
    end
    return m;
end

local function matmul(a, b, nn)
    local m = nn; -- a:len();
    local n = nn; -- a[1]:len();
    local p = nn; -- b[1]:len();

    local b2 = {};
    for i = 1, n do
        b2[i] = {};
        for j = 1, p do
            b2[i][j] = 0;
        end
    end

    for i = 1, n do
        for j = 1, p do
            b2[j][i] = b[i][j];
        end
    end

    local c = {};
    for i = 1, m do
        ci = {};
        ai = a[i];

        for j = 1, n do
            local s = 0;
            local b2j = b2[j];

            for k = 1, p do
                s = s + ai[k] * b2j[k];
            end

            ci[j] = s;
        end

        c[i] = ci;
    end

    return c;
end

local function run(N)
    local start_time = os.clock();
    local a = matgen(N);
    local b = matgen(N);
    local c = matmul(a, b, N);

    local v = c[N / 2 + 1][N / 2 + 1];
    io.write(string.format("%0.9f\n",v));
    io.stderr:write(string.format("time(%.9f)\n", os.clock() - start_time));    
end

local N = tonumber(arg and arg[1]) or 10
local times = tonumber(arg and arg[2]) or 1

io.stderr:write("started")

for i=1,times,1 do
  run(N)
end
