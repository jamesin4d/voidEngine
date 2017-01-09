velocity = class:extend()
function velocity:init(vx,vy,a,d,mv)
  self.vx,self.vy = vx or 0, vy or 0
  self.accel = a or 25
  self.decel = d or 80
  self.maxVel = mv or 50
end
return velocity
