local Can = {}

Can.__index = Can

function Can.new(x, y, xv, yv, resources, world)
  local self = setmetatable({}, Can)
  self.name = 'Can'
  self.x = x
  self.y = y
  self.xv = xv
  self.yv = yv
  self.mass = 5
  self.world = world
  self.body = love.physics.newBody(self.world, self.x, self.y, "dynamic")
  self.shape = love.physics.newRectangleShape(0, 0, 25, 10)
  self.fixture = love.physics.newFixture(self.body, self.shape, self.mass)
  self.fixture:setUserData(self)
  self.body:setAngularVelocity(0.05)
  self.body:setLinearVelocity(xv, yv)
  self.image = love.graphics.newImage("images/water_can.png")
  self.resources = resources
  self.consumed = false
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

function Can.coll(self, o)
end

return Can
