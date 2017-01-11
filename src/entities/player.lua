local colorComp = require "src.components.colorComponent"
local velocityComp = require "src.components.velocityComponent"
local rectComp = require "src.components.rectComponent"
local colliderComp = require "src.components.collisionFlag"

local function newPlayable(world,x,y,w,h)
  --body...
  local player = {
    world = world,
    vel = velocityComp(),
    rect = rectComp(x,y,w,h),
    control = true,
    color = colorComp(130,130,80),
    collider = colliderComp("kinetic")
 }
 encos.createEntity(player)
 mem:emit("entityCreate",player)
  return player
end
return newPlayable
