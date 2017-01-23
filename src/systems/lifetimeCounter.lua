-- i've written this function several different ways and still it refuses
-- to work. which is irritating as fuck since it should be simple

local lifetimeCounter = encos.createSystem(
  {"lived","lifetime"},
  function(item,lived,lifetime)
    if item.lived >= lifetime then item.world:remove(item)
    else item.lived = item.lived + 0.2
    end
  end)
return lifetimeCounter
