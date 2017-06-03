-- reworking world to remove grid dependancy
local world = {} -- the world
local wmt = {__index = world} -- it handles spatial data
local rectFunc = require "src.rectFunctions"

function world:itemCount()
  local len = 0
  for _ in pairs(self.rects) do len = len + 1 end
  return len
end

function world:getItems()
  local items, len = {}, 0
  for i, _ in pairs(self.rects) do
    len = len+1
    items[len] = i
  end
  return items,len
end

function world:getEntities()
  return self.entities
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
  table.insert(self.entities,entity)
  local x,y,w,h = entity:getComponents({"rect"}):getRect()
  self.rects[entity] = {x=x,y=y,w=w,h=h}
  return entity
end

function world:remove(entity)
  local x,y,w,h = entity:getComponents({"rect"}):getRect()
  self.rects[entity] = nil
  for k,v in pairs(self.entities) do if v == entity then table.remove(self.entities,k) end end
end

--given a rect returns items, len; table, integer
function world:queryRect(x,y,w,h)
  local items,len = {}, 0
  local rect
  for i, _ in pairs(self.rects) do
    rect = self.rects[i]
    if rectFunc.rectsIntersect(x,y,w,h,rect.x,rect.y,rect.w,rect.h) then
      len = len + 1
      items[len] = i
    end
  end
  return items, len
end

function world:queryPoint(x,y)
  local items, len = {}, 0
  local rect
  for i, _ in pairs(self.rects) do
    rect = self.rects[i]
    if rectFunc.containsPoint(rect.x,rect.y,rect.w,rect.h,x,y) then
      len = len + 1
      items[len] = i
    end
  end
  return items, len
end

function world:update(entity)
  local x1,y1,w1,h1 = self:getRect(entity) -- the world stores original position data
  local x2,y2,w2,h2 = entity:getComponents({"rect"}):getRect() -- get current data
  if x1~=x2 or y1~=y2 or w1~=w2 or h1~=h2 then -- if old/new values differ
    local rect = self.rects[entity] -- update world data for entity
    rect.x,rect.y,rect.w,rect.h = x2,y2,w2,h2
  end
end

local function newWorld(cellSize)
  local cs = cellSize or 16
  local wld = setmetatable({
    cellSize = cs,
    rects = {},
    entities = {},
    rows = {},
    nonEmptyCells = {},
  }, wmt)
  return wld
end
return newWorld
