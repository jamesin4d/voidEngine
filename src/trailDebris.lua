local spawnDebris = require "src.entities.spawnDebris"
local trail = encos.createSystem(
  {"world","collider","control"},
  function(item,world,collider,control)
    if collider.moving then spawnDebris(1,world,item.rect:center()) end 
  end)
return trail
