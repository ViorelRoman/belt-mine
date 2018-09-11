local Asteroid = {}

math.randomseed(os.time())

Asteroid.__index = Asteroid

function Asteroid.new(x, y, mass, rotation, world)
  local self = setmetatable({}, Asteroid)
  self.x = x
  self.y = y
  self.mass = mass
  self.world = world
  self.body = love.physics.newBody(self.world, self.x, self.y, "dynamic")
  self.shape = love.physics.newRectangleShape(0, 0, 70, 96)
  self.fixture = love.physics.newFixture(self.body, self.shape, self.mass)
  self.image = love.graphics.newImage("asteroid.png")
  self.body:setAngle(rotation)
  self.body:setLinearVelocity(math.random(-10, 10), math.random(-10, 10))
  self.body:setAngularVelocity(math.random())
  return self
end

function Asteroid.draw(self)
  love.graphics.draw(
    self.image, 
    self.body:getX(),
    self.body:getY(), self.body:getAngle(),
    1, 1,
    self.image:getWidth() / 2,
    self.image:getHeight() / 2
  )
end

return Asteroid
