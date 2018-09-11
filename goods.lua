local Can = {}

Can.__index = Can

function Can.new(x, y, xv, yv, world)
  local self = setmetatable({}, Can)
  self.x = x
  self.y = y
  self.xv = xv
  self.yv = yv
  self.ammo = 100
  self.fuel = 100
  self.mass = 5
  self.world = world
  self.body = love.physics.newBody(self.world, self.x, self.y, "dynamic")
  self.shape = love.physics.newRectangleShape(0, 0, 25, 10)
  self.fixture = love.physics.newFixture(self.body, self.shape, self.mass)
  self.body:setAngularVelocity(0.05)
  self.body:setLinearVelocity(xv, yv)
  self.image = love.graphics.newImage("water_can.png")
  return self
end

function Can.update(self, dt)
end

function Can.draw(self)
  love.graphics.draw(
    self.image, 
    self.body:getX(),
    self.body:getY(), self.body:getAngle(),
    1, 1,
    self.image:getWidth() / 2,
    self.image:getHeight() / 2
  )
end

return Can
