local function newBlock(world,x,y,w,h)
  local block = {
    world = world,
    vel = velocityComp(),
    rect = rectComp(x,y,w,h),
    color = colorComp(180,180,180),
    collider = colliderComp({"solid"})
  }
  encos.createEntity(block)
  mem:emit("entityCreate",block)
  return block
end
return newBlock
