
local function resolveX(item,other)
  local r1 = item:getComponents({"rect"})
  local r2 = other:getComponents({"rect"})
  local displace = 0
  local left1,right1,left2,right2 = r1.x, r1.x+r1.width, r2.x, r2.x+r2.width
  if right1 >= left2 and left1 < left2 then
    item.vel.vx = 0
    displace = left2-right1
  end
  if left1 <= right2 and right1 > right2 then
    displace = right2-left1
    item.vel.vx = 0
  end
  item.rect.x = item.rect.x+displace
  item.rect.y = item.rect.y
end

local function resolveY(item,other)
  local r1 = item:getComponents({"rect"})
  local r2 = other:getComponents({"rect"})
  local displace = 0
  local top1,bottom1,top2,bottom2 = r1.y, r1.y+r1.height, r2.y, r2.y+r2.height
  if bottom1 >= top2 and top2 > top1 then
    item.vel.vy = 0
    displace = top2-bottom1
  end
  if top1 <= bottom2 and bottom1 > bottom2 then
    item.vel.vy = 0
    displace = bottom2 -top1
  end
  item.rect.y = item.rect.y + displace
  item.rect.x = item.rect.x
end

local function resolve(item,other,vector)
  if vector == "x" then resolveX(item,other)
  elseif vector == "y" then resolveY(item,other)
  end
end

return resolve
