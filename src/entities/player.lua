local function newPlayable(world,x,y,w,h)
  --body...
  local player = {
    world = world,
    vel = velocityComp(),
    rect = rectComp(x,y,w,h),
    control = true,
    color = colorComp(130,130,80),
    collider = colliderComp({"solid","player"})
 }
 encos.createEntity(player)
 mem:emit("entityCreate",player)
  return player
end
return newPlayable
