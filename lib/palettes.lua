local pal = {}

pal.pico8 = {
  ["000000"] = 0,
  ["1D2B53"] = 1,
  ["7E2553"] = 2,
  ["008751"] = 3,
  ["AB5236"] = 4,
  ["5F574F"] = 5,
  ["C2C3C7"] = 6,
  ["FFF1E8"] = 7,
  ["FF004D"] = 8,
  ["FFA300"] = 9,
  ["FFEC27"] = "a",
  ["00E436"] = "b",
  ["29ADFF"] = "c",
  ["83769C"] = "d",
  ["FF77A8"] = "e",
  ["FFCCAA"] = "f",
}

pal.tic80 = {
  ["140C1C"] = 0,
  ["442434"] = 1,
  ["30346D"] = 2,
  ["4E4A4F"] = 3,
  ["854C30"] = 4,
  ["346524"] = 5,
  ["D04648"] = 6,
  ["757161"] = 7,
  ["597DCE"] = 8,
  ["D27D2C"] = 9,
  ["8595A1"] = "a",
  ["6DAA2C"] = "b",
  ["D2AA99"] = "c",
  ["6DC2CA"] = "d",
  ["DAD45E"] = "e",
  ["DEEED6"] = "f",
}

pal.default = pal.tic80

pal._invert = function(pal)
  local new_pal = {}
  for i,v in pairs(pal) do
    new_pal[v] = i
  end
  return new_pal
end

return pal
