local velocity = class:extend()
function velocity:init(vx,vy,a,d,mv)
  self.vx,self.vy = vx or 0, vy or 0
  self.accel = a or 5
  self.decel = d or 20
  self.maxVel = mv or 5
end
return velocity
