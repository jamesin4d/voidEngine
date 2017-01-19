local each = require "src.lib.encos"
local rectFunc = require "src.physics.rectFunctions"

local function resolve(one, two,vector)
  local r1 = one:getComponents({"rect"})
  local r2 = two:getComponents({"rect"})

  if vector == "x" then
    local displace = 0
    local left1,right1,left2,right2 = r1.x, r1.x+r1.width, r2.x, r2.x+r2.width
    if right1 >= left2 and left1 < left2 and right2 > right1 then
      one.vel.vx = 0
      displace = left2-right1
    end
    if left1 <= right2 and right1 > right2 and left1 > left2 then
      displace = right2-left1
      one.vel.vx = 0
    end
    one.rect.x = one.rect.x+displace
    one.rect.y = one.rect.y
  end

  if vector == "y" then
    local displace = 0
    local top1,bottom1,top2,bottom2 = r1.y, r1.y+r1.height, r2.y, r2.y+r2.height
    if bottom1 >= top2 and top2 > top1 and bottom1 < bottom2 then
      one.vel.vy = 0
      displace = top2-bottom1
    end
    if top1 <= bottom2 and top2 < top1 and bottom1 > bottom2  then
      one.vel.vy = 0
      displace = bottom2 -top1
    end
    one.rect.y = one.rect.y + displace
    one.rect.x = one.rect.x
  end
end

local function detect(item,vector)
  local rect,vel,world,collider = item:getComponents({"rect","vel","world","collider"})
  if vel.vx ~= 0 or vel.vy ~= 0 then collider.moving = true end
  if vel.vx == 0 and vel.vy == 0 then collider.moving = false end
  -- goal values are where the rect is attempting to move to
  local goalX,goalY = rect.x + vel.vx, rect.y + vel.vy
  --movement rect bounds: left top right bottom width height
  local boundL, boundT = math.min(goalX,rect.x), math.min(goalY,rect.y)
  local boundR, boundB = math.max(goalX+rect.width, rect.x+rect.width), math.max(goalY+rect.height,rect.y+rect.height)
  local boundW, boundH = boundR-boundL, boundB-boundT
  local others,len = world:queryRect(boundL,boundT,boundW,boundH)
  for i,v in pairs(others) do
    if v ~= item then
      if rectFunc.isIntersecting(item,v) then
        item.collider.colliding = true
        resolve(item,v,vector)
      end
    end
  end
end
return detect
