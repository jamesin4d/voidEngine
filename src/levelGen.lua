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
  local wallLeft = 16
  for i = 0, wallLeft-1 do
    local ft = block(world,0,i*hh/wallLeft,cs,hh/wallLeft)
  end
  local wallRight = 16
  for i = 0, wallRight-1 do
    local ft = block(world,ww-cs,i*hh/wallRight,cs,hh/wallRight)
  end
  local roofTiles = 16
  for i = 0, roofTiles-1 do
    local rt = block(world,i*ww/roofTiles,0,ww/roofTiles,cs)
  end
  local floorTiles = 16
  for i = 0, floorTiles-1 do
    local ft = block(world,i*ww/floorTiles,hh-cs,ww/floorTiles,cs)
  end
  local randomBlocks = 32
  for i = 0, randomBlocks-1 do
    local rx,ry = math.random(cs*2, ww-(cs*3)),math.random(cs*2, hh-(cs*3))
    local rb = block(world,rx,ry,cs*2,cs*2)
  end
end

local gen = {
  newLevel = newLevel,
  level = level
}

return gen
