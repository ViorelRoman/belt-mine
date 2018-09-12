local Asteroid = {}

math.randomseed(os.time())

AsteroidTypes = {
  M = love.graphics.newImage("images/asteroid_m.png"),
  C = love.graphics.newImage("images/asteroid_c.png"),
  S = love.graphics.newImage("images/asteroid_s.png")
}

Asteroid.__index = Asteroid

function Asteroid.new(x, y, mass, rotation, asteroid_type, world)
  local self = setmetatable({}, Asteroid)
  self.name = 'Asteroid'
  self.x = x
  self.y = y
  self.mass = mass
  self.world = world
  self.asteroid_type = asteroid_type
  self.body = love.physics.newBody(self.world, self.x, self.y, "dynamic")
  self.shape = love.physics.newCircleShape(48)
  self.fixture = love.physics.newFixture(self.body, self.shape, self.mass)
  self.fixture:setUserData(self)
  self.image = AsteroidTypes[self.asteroid_type]
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

function Asteroid.coll(obj)
end

return Asteroid
