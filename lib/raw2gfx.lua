return function(filename,pal)

  local data = {}

  for line in io.lines(filename) do
    -- 117,127: (65535,61937,59624)  #FFF1E8  srgb(255,241,232)
    --print(string.match(line,'^(%d+),(%d+):%s*%(%s*(%d+),%s*(%d+),%s'))
    local rx,ry,_,_,_,hex,_ = string.match(line,
      '^(%d+),(%d+):%s+%(%s*(%d+),%s*(%d+),%s*(%d+)%)%s+#(%x+)%s+(.+)$')
    local mx,my = tonumber(rx)+1,tonumber(ry)+1
    assert(pal[hex],'invalid color: '..hex)
    if not data[my] then
      data[my] = {}
    end
    data[my][mx] = pal[hex]
  end

  local output = ""

  for x,n in ipairs(data) do
    for y,v in ipairs(n) do
      output = output .. v
    end
    if #data ~= x then
      output = output .. "\n"
    end
  end

  return output

end
