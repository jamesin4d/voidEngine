local block = require "src.entities.block"

local function newLevel(size,cs,world)
  local cell = cs or 16
  local lx = {5,6,5,6}
  local ly = {4,4,5,5}
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

local function level(world)
  local ww = love.graphics.getWidth()
  local hh = love.graphics.getHeight()
  local cs = world.cellSize
  local lvl = {
  -- walls and ceiling
  roof = block(world,0,0,ww,cs),
  wall1 = block(world,0,cs,cs,hh-cs),
  wall2 = block(world,ww-cs,cs,cs,hh-cs)
}
  local floorTiles = 16
  for i = 0, floorTiles-1 do
    local ft = block(world,i*ww/floorTiles,hh-cs,ww/floorTiles,cs)
    table.insert(lvl,ft)
  end
  return lvl
end

local gen = {
  newLevel = newLevel,
  level = level
}

return gen
