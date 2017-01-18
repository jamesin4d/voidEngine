--this component describes collider type for entity
local cf = class:extend("collisionFlag")
-- takes a table as an argument; cf({"bullet"}) for example
-- inits with the bullet flag set to true
function cf:init(...)
  self.solid = false
  self.mobile = false
  self.player = false
  self.enemy = false
  self.bullet = false
  self.pickup = false
  self.exit = false
  self.colliding = false
  for _,i in ipairs(...) do
    local v = self[i]
    if v == nil then return end
    self[i] = true
  end
end
return cf
