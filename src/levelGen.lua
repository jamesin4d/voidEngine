local block = require "src.entities.block"

local function newLevel(size,cs,world)
  local cell = cs or 32
  local lx = {5,6,5,6}
  local ly = {5,5,6,6}
  local level = {}
  math.randomseed(os.time())
  for i = 1, size do
    lx[#lx+1], ly[#ly+1] = lx[#lx-3] + math.random(-1, 1), ly[#ly-3] + math.random(-1, 1)
    lx[#lx+1], ly[#ly+1] = lx[#lx]+1, ly[#ly]+1
    lx[#lx+1], ly[#ly+1] = lx[#lx]-1, ly[#ly]
    lx[#lx+1], ly[#ly+1] = lx[#lx]+1, ly[#ly]-1
  end
  for i=1, #lx do
    local bx,by = lx[i]*cell,ly[i]*cell
    local bw,bh = cell,cell
    local bl = block(world,bx,by,bw,bh)
    table.insert(level,bl)
  end
  return level
end

local function level(args)
  local cell = 32
  local ww = love.graphics.getWidth()
  local hh = love.graphics.getHeight()

end

return newLevel
