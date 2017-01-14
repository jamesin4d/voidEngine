local encos = require "src.lib.encos"
local collisionSys = encos.createSystem(
  {'vel','rect','collider'},
  function(item,vel,rect,collider)
    if vel.vx ~= 0 or vel.vy ~= 0 then
      collider.moving = true
    elseif vel.vx == 0 and vel.vy == 0 then
      collider.moving = false
    end

end)
return collisionSys
