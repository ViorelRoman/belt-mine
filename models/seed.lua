local Seed = {}

Seed.__index = Seed

function Seed.new(x, y, angle, xv, yv, world)
  local self = setmetatable({}, Seed)
  self.name = 'Seed'
  self.x = x
  self.y = y
  self.world = world
  self.consumed = false
  self.mass = 10

  
  self.body = love.physics.newBody(self.world, self.x, self.y, "dynamic")
  self.shape = love.physics.newRectangleShape(0, 0, 30, 29)
  self.fixture = love.physics.newFixture(self.body, self.shape, self.mass)
  self.fixture:setUserData(self)
  self.body:setLinearVelocity(xv + (1000 * math.cos(angle)), yv + (1000 * math.sin(angle)))
  self.image = love.graphics.newImage("images/seed.png")

  return self
end

function Seed.update(self, dt)
end

function Seed.hud(self)
end

function Seed.draw(self)
  love.graphics.draw(
    self.image, 
    self.body:getX(),
    self.body:getY(), self.body:getAngle(),
    1, 1,
    self.image:getWidth() / 2,
    self.image:getHeight() / 2
  )
end

function Seed.coll(self, obj)
end

function Seed.keypressed(self, key)
end

function Seed.keyreleased(self, key)
end

return Seed
