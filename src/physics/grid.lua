local each = encos.each
local floor = math.floor
local ceil = math.ceil
local initStep = require "src.physics.traverseStep"

local function toWorld(cs,cx,cy)
  return (cx-1)*cs,(cy-1)*cs
end

local function toCell(cs,x,y)
  return floor(x/cs)+1, floor(y/cs)+1
end

local function toCellRect(cs,x,y,w,h)
    local cx,cy = toCell(cs,x,y)
    cr,cb = ceil((x+w)/cs), ceil((y+h)/cs)
    return cx,cy, cr-cx+1, cb-cy+1
end

local function addItemToCell(grid,item,cx,cy)
  grid.rows[cy] = grid.rows[cy] or setmetatable({}, {__mode="v"})
  local row = grid.rows[cy]
  row[cx] = row[cx] or {itemCount = 0, x=cx, y=cy, items=setmetatable({},{__mode = "k"})}
  local cell = row[cx]
  grid.nonEmptyCells[cell] = true
  if not cell.items[item] then
    cell.items[item] = true
    cell.itemCount = cell.itemCount + 1
  end
end

local function removeItemFromCell(grid,item,cx,cy)
  local row = grid.rows[cy]
  if not row or not row[cx] or not row[cx].items[item] then return false end
  local cell = row[cx]
  cell.items[item] = nil
  cell.itemCount = cell.itemCount - 1
  if cell.itemCount == 0 then grid.nonEmptyCells[cell] = nil end
  return true
end

local function getItemsInRect(grid,cl,ct,cw,ch)
  local dict = {}
  for cy = ct, ct+ch-1 do
    local row = grid.rows[cy]
    if row then
      for cx = cl, cl+cw-1 do
        local cell = row[cx]
        if cell and cell.itemCount > 0 then
          for item, _ in pairs(cell.items) do
            dict[item] = true
          end
        end
      end
    end
  end
  return dict
end

local function traverse(cs, x1,y1,x2,y2,f) -- (cellSize,start point,end point, function(cx,cy))
  -- this is probably one of the more confusing pieces of code i've worked with.
  local cx1,cy1 = toCell(cs,x1,y1)
  local cx2,cy2 = toCell(cs,x2,y2)
  local stepX,dx,tx = initStep(cs,cx1,x1,x2)
  local stepY,dy,ty = initStep(cs,cy1,y1,y2)
  local cx,cy = cx1,cy1

  f(cx,cy) -- THIS is a legendary lambda function i believe.
  while math.abs(cx-cx2)+math.abs(cy-cy2)>1 do
    if tx<ty then
      tx, cx = tx+dx, cx+stepX
      f(cx,cy)
    else
      if tx == ty then f(cx+stepX, cy) end
      ty, cy = ty+dy, cy+stepY
      f(cx,cy)
    end
  end
  if cx ~= cx2 or cy ~=cy2 then f(cx2,cy2) end
end

local function getCellsAlongSegment(grid,x1,y1,x2,y2)
  local cells, len, visited = {},0,{}
  traverse(grid.cellSize,x1,y1,x2,y2,  function(cx,cy)
      local row = grid.rows[cy]
      if not row then return end
      local cell = row[cx]
      if not cell or visited[cell] then return end
      visited[cell] = true
      len = len+1
      cells[len] = cell
    end)
  return cells, len
end

local grid = {
  addItem = addItemToCell,
  removeItem = removeItemFromCell,
  getItemsInRect = getItemsInRect,
  toCell = toCell,
  toWorld = toWorld,
  toCellRect = toCellRect
}

return grid
