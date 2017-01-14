local colorComp = require "src.components.colorComponent"
local velocityComp = require "src.components.velocityComponent"
local rectComp = require "src.components.rectComponent"
local colliderComp = require "src.components.collisionFlag"

local function newDebris(world,x,y)
  -- body...
  local rw,rh = math.random(1,4),math.random(1,4)
  local rvx = math.random(-5,5)
  local rvy = math.random(-5,5)

  local deb = {
    world = world,
    color = colorComp(120,120,120),
    rect = rectComp(x,y,rw,rh),
    vel = {
      vx = rvx,
      vy = rvy,
      maxVel = 15
    }
  }
end

return newDebris
