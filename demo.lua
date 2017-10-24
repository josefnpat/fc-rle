-- title:  RLE Demo
-- author: @josefnpat
-- desc:   Runtime Length Encoding Demo
-- script: lua
rle = {}
rle.plookup = "abcdefghijklmnop"
rle.clookup = [[-!"#$%()*,./:;?[^_{}+<=>0123456789qrstuvwxyz]]
rle.indexof = function(s,c)
  local ret=-1
  for i=1,#s do
    if (string.sub(s,i,i)==c) then
      return i
    end
  end
  return ret
end
rle.render = function(str,sx,sy,sw,callback)
  sx = sx or 0
  sy = sy or 0
  sw = sw or 240
  callback = callback or function(x,y,c) pix(x,y,c) end

  local img,i={},1
  while (i<#str) do
  local p=rle.indexof(rle.plookup,string.sub(str,i,i))
  local c=rle.indexof(rle.clookup,string.sub(str,i+1,i+1))
  if c==-1 then
    c=1
    i=i+1
  else
    i=i+2
  end
  for k=1,c do
    table.insert(img,p)
  end
  end
  local x,y,offsetx = sx,sy,0
  for i,v in pairs(img) do
  callback(x,y,v-1)
  x,offsetx = x+1,offsetx+1
  if x>sx+sw-1 then
    x,y,offsetx = sx,y+1,0
  end
  end
end

offset = 0
ei = 1

example_renders = {
  {n="default",c=function(x,y,c)
    pix(x,y,c)
  end},
  {n="flip vertical",c=function(x,y,c)
    pix(x,135-y,c) -- flip v and h
  end},
  {n="flip horizontal",c=function(x,y,c)
    pix(239-x,y,c) -- flip v and h
  end},
  {n="transparent",c=function(x,y,c)
    if c ~= 0 then
      pix(x,y,c) -- flip v and h
  end
  end},
  {n="modulo",c=function(x,y,c)
    pix((x+offset)%240,(y+offset)%136,c)
  end},
  {n="rotate",c=function(x,y,c)
    pix(y,x,c)
  end},
  {n="stretch",c=function(x,y,c)
    pix(x*2,y,c)
  pix(x*2+1,y,c)
  end},
  {n="palette change",c=function(x,y,c)
    pix(x,y,c==0 and 15 or c-1)
  end},
}

ii = 1

function TIC()
  cls(offset%15+1)
  offset = offset + 1

  if btnp(4) then
    ii = ii + 1
    if ii > #d then
      ii = 1
    end
  end

  if btnp(5) then
    ei = ei + 1
    if ei > #example_renders then
      ei = 1
    end
  end

  render = example_renders[ei]
  image = d[ii]

  -- the magic
  rle.render(image,0,0,240,render.c)

  str = render.n..' (RLE len: '..#image..')'
  for x = -1,1 do
    for y = -1,1 do
      print(str,1+x,1+y,0)
    end
  end
  print(str,1,1)
end

a=table.insert
d = {}
