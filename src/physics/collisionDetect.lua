local rectFunc = require "src.physics.rectFunctions"
local resolve = require "src.physics.collisionResolve"

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
      local collision = rectFunc.isIntersecting(item,v)
      if collision == false then item.collider.colliding = false end
      if collision then
        collider.colliding = true
        resolve(item,v,vector)
      end
    end
  end
end
return detect
