local function spawnDebris(amount,world,x,y)
  for i=0, amount-1 do
    local d = newDebris(world,x,y)
  end
end
return spawnDebris
