

local function newDebris(world,x,y)
  -- body...
  math.randomseed(love.timer.getTime())
  local rw,rh = math.random(2,6),math.random(2,6)
  local rvx = math.random(-1,1)
  local rvy = math.random(-1,1)

  local deb = {
    world = world,
    color = colorComp(222,222,222),
    rect = rectComp(x,y,rw,rh),
    lived = 0,
    lifetime = 5,
    collider = colliderComp({}),
    vel = {
      vx = rvx,
      vy = rvy,
      maxVel = 15
    }}
    encos.createEntity(deb)
    mem:emit('entityCreate',deb)
    return deb
end

return newDebris
