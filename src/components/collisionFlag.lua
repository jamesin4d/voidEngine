local cf = class:extend("collisionFlag")
function cf:init(s,m)
  self.solid = s or false
  self.mobile = m or false
end
return cf
