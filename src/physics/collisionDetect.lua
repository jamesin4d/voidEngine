local each = require "src.lib.encos"
local rectFunc = require "src.physics.rectFunctions"

local function detect(item)
  local rect,vel,world,collider = item:getComponents({"rect","vel","world","collider"})
  local left,top,right,bottom = rect.x,rect.y, rect.x+rect.width, rect.y+rect.height
  if vel.vx ~= 0 or vel.vy ~= 0 then
    collider.moving = true
  elseif vel.vx == 0 and vel.vy == 0 then
    collider.moving = false
  end
  if collider.moving then
    local horizontalDirection, verticalDirection
    -- ooh man, i have no idea whats going on
    -- goal values are where the rect is attempting to move to
    local goalX,goalY = rect.x + vel.vx, rect.y + vel.vy
    if vel.vx > 0 then horizontalDirection = "right"
    elseif vel.vx < 0 then horizontalDirection = "left"
    else horizontalDirection = nil
    end
    if vel.vy > 0 then verticalDirection = "down"
    elseif vel.vy < 0 then verticalDirection = "up"
    else verticalDirection = nil
    end

    --movement rect bounds: left top right bottom width height
    local boundL, boundT = math.min(goalX,rect.x), math.min(goalY,rect.y)
    local boundR, boundB = math.max(goalX+rect.width, rect.x+rect.width), math.max(goalY+rect.height,rect.y+rect.height)
    local boundW, boundH = boundR-boundL, boundB-boundT
    local others = world:queryRect(boundL,boundT,boundW,boundH)
    for i,v in pairs(others) do
      if rectFunc.isIntersecting(item,v) then
        local left,top,right,bottom = item.rect.x,item.rect.y, item.rect.x+item.rect.width, item.rect.y+item.rect.height
        local vl,vt,vr,vb = v.rect.x,v.rect.y, v.rect.x+v.rect.width,v.rect.y+v.rect.height
        if horizontalDirection == "right" or horizontalDirection == "left" then
          if right == vl then
            item.rect.x = v.rect.x-item.rect.width
            item.vel.vx = 0
          end
          if left == vr then
            item.rect.x = v.rect.x+v.rect.width
            item.vel.vx = 0
          end
          --item.vel.vx = 0
        end
        if verticalDirection == "up" or verticalDirection == "down" then
          if top == vb then
            item.rect.y = v.rect.y+v.rect.height
            item.vel.vy = 0
          end
          if bottom == vt then
            item.rect.y = v.rect.y-item.rect.height
            item.vel.vy = 0
          end
          --item.vel.vy = 0
        end
      end
  end
end



end

return detect
