--color component used
local color = class:extend('color')
function color:init(r,g,b,a)
  self.r,self.g,self.b = r,g,b
  self.alpha = a
end
return color
