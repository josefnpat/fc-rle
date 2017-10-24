return function(filename,pal)

  local plookup = "abcdefghijklmnop"
  local clookup = [[-!"#$%()*,./:;?[^_{}+<=>0123456789qrstuvwxyz]]

  local map = {
    ["a"] = 10,
    ["b"] = 11,
    ["c"] = 12,
    ["d"] = 13,
    ["e"] = 14,
    ["f"] = 15,
  }

  local data = {}
  local xmax,ymax = 0,0
  for line in io.lines(filename) do
    data[xmax] = {}
    for y = 0,#line do
      local hex = string.sub(line,y,y)
      data[xmax][y-1] = tonumber(hex) or map[hex]
      ymax = math.max(ymax,y)
    end
    xmax = xmax + 1
  end

  local sget = function(y,x)
    assert(data[x] and data[x][y],"No data: x:"..tostring(x).." y:"..tostring(y))
    return data[x][y]
  end

  --local img2str = function(sx,sy,sx2,sy2)
  local sx,sy,sx2,sy2 = 0,0,ymax-1,xmax-1

  local p = -1
  local c = 1
  local img = ""
  for y = sy,sy2 do
    for x = sx,sx2 do
      local px = sget(x,y)+1
      if (px ~= p or c>=#clookup) then
        if (p ~= -1) then
          img = img..string.sub(plookup,p,p)
          if (c>1) then
           img = img..string.sub(clookup,c,c)
          end
        end
        p = px
        c = 1
      else
        c = c + 1
      end
    end
  end
  img = img..string.sub(plookup,p,p)..string.sub(clookup,c,c)
  print(img)
  --end

  --print(img2str(0,0,ymax-1,xmax-1))
end
