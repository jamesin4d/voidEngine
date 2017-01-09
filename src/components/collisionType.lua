local collider = class:extend("collider")
function collider:init(type)
  self.type = type
end

return collider
