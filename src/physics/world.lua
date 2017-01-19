local world = {} -- the world is essentially a grid instance
local wmt = {__index = world} -- it handles spatial data
local grid = require "src.physics.grid"
local rectFunc = require "src.physics.rectFunctions"

function world:itemCount()
  local len = 0
  for _ in pairs(self.rects) do len = len + 1 end
  return len
end

function world:cellCount()
  local c = 0
  for _,row in pairs(self.rows) do
    for _,_ in pairs(row) do
      c = c+1
    end
  end
  return c
end

function world:getItems()
  local items, len = {}, 0
  for i, _ in pairs(self.rects) do
    len = len+1
    items[len] = i
  end
  return items,len
end

function world:has(entity)
  return not not self.rects[entity]
end

function world:getRect(entity)
  local rect = self.rects[entity]
  if not rect then error("entity not added to world") end
  return rect.x,rect.y,rect.w,rect.h
end

function world:add(entity)
  local ent = self.rects[entity]
  if ent then error('entity already added') end
  local rect = entity:getComponents({"rect"})
  local x,y,w,h = rect.x,rect.y,rect.width,rect.height
  self.rects[entity] = {x=x,y=y,w=w,h=h}
  local cl,ct,cw,ch = grid.toCellRect(self.cellSize,x,y,w,h)
  for cy = ct, ct+ch-1 do
    for cx = cl, cl+cw-1 do
      grid.addItem(self,entity,cx,cy)
    end
  end
  return entity
end

function world:remove(entity)
  local rect = entity:getComponents({"rect"})
  local x,y,w,h = rect.x,rect.y,rect.width,rect.height
  self.rects[entity] = nil
  local cl,ct,cw,ch = grid.toCellRect(self.cellSize, x,y,w,h)
  for cy = ct, ct+ch-1 do
    for cx = cl, cl+cw-1 do
      grid.removeItem(self,entity,cx,cy)
    end
  end
end

--given a rect returns items, len; table, integer
function world:queryRect(x,y,w,h)
  local cl,ct,cw,ch = grid.toCellRect(self.cellSize,x,y,w,h)
  local dict = grid.getItemsInRect(self,cl,ct,cw,ch)
  local items,len = {}, 0
  local rect
  for i, _ in pairs(dict) do
    rect = self.rects[i]
    if rectFunc.rectsIntersect(x,y,w,h,rect.x,rect.y,rect.w,rect.h) then
      len = len + 1
      items[len] = i
    end
  end

  return items, len
end

function world:queryPoint(x,y)
  local cx,cy = grid.toCell(self.cellSize,x,y)
  local dict = grid.getItemsInRect(self.cellSize,cx,cy,1,1)
  local items, len = {}, 0
  local rect
  for i, _ in pairs(dict) do
    rect = self.rects[i]
    if rectFunc.containsPoint(rect.x,rect.y,rect.width,rect.height,x,y) then
      len = len + 1
      items[len] = i
    end
  end
  return items, len
end

function world:update(entity)
  local x1,y1,w1,h1 = self:getRect(entity) -- the world stores original position data
  local r = entity:getComponents({"rect"}) -- grab current data from the entity
  local x2,y2,w2,h2 = r.x,r.y,r.width,r.height
  if x1~=x2 or y1~=y2 or w1~=w2 or h1~=h2 then -- if old/new values differ
    local cs = self.cellSize -- find out whether the entity has left/entered cell
    local cl1,ct1,cw1,ch1 = grid.toCellRect(cs,x1,y1,w1,h1)
    local cl2,ct2,cw2,ch2 = grid.toCellRect(cs, x2,y2,w2,h2)
    if cl1~=cl2 or ct1~=ct2 or cw1~=cw2 or ch1~=ch2 then
      local cr1,cb1 = cl1+cw1-1, ct1+ch1-1
      local cr2,cb2 = cl2+cw2-1, ct2+ch2-1
      local cyOut
-- leaving a cell
      for cy = ct1,cb1 do
        cyout = cy<ct2 or cy>cb2
        for cx = cl1,cr1 do
          if cyout or cx<cl2 or cx>cr2 then
            grid.removeItem(self,entity,cx,cy)
          end
        end
      end
-- entering a cell
      for cy = ct2,cb2 do
        cyout = cy<ct1 or cy>cb1
        for cx = cl2,cr2 do
          if cyout or cx<cl1 or cx>cr1 then
            grid.addItem(self,entity,cx,cy)
          end
        end
      end
    end
    local rect = self.rects[entity] -- update world data for entity
    rect.x,rect.y,rect.w,rect.h = x2,y2,w2,h2
  end
end

local function newWorld(cellSize)
  local cs = cellSize or 16
  local wld = setmetatable({
    cellSize = cs,
    rects = {},
    rows = {},
    nonEmptyCells = {},
  }, wmt)
  return wld
end
return newWorld
