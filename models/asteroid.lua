local Can = require "models.goods"
local Asteroid = {}

math.randomseed(os.time())

AsteroidTypes = {
  M = {
	  images={love.graphics.newImage("images/asteroid_m.png"), love.graphics.newImage("images/asteroid_m_seeded.png")},
	  resources={
		  iron=8000,
		  silicate=2000,
		  water=0,
		  phosphate=0,
		  carbon=0
	  }
  },
  C = {
	  images={love.graphics.newImage("images/asteroid_c.png"), love.graphics.newImage("images/asteroid_c_seeded.png")},
	  resources={
		  iron=0,
		  silicate=2000,
		  water=1000,
		  phosphate=1000,
		  carbon=6000
	  }
  },
  S = {
	  images={love.graphics.newImage("images/asteroid_s.png"), love.graphics.newImage("images/asteroid_s_seeded.png")},
	  resources={
		  iron=500,
		  silicate=7000,
		  water=2000,
		  phosphate=500,
		  carbon=100
	  }
  },
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
  self.resources = AsteroidTypes[self.asteroid_type]["resources"]
  self.collected = {
	  iron=0,
	  silicate=0,
	  water=0,
	  phosphate=0,
	  carbon=0
  }
  self.seeded = false

  self.body = love.physics.newBody(self.world, self.x, self.y, "dynamic")
  self.shape = love.physics.newCircleShape(48)
  self.fixture = love.physics.newFixture(self.body, self.shape, self.mass)
  self.fixture:setUserData(self)
  self.image = AsteroidTypes[self.asteroid_type]["images"][1]
  self.body:setAngle(rotation)
  self.body:setLinearVelocity(math.random(-10, 10), math.random(-10, 10))
  self.body:setAngularVelocity(math.random())
  return self
end

function Asteroid.seedit(self)
  self.image = AsteroidTypes[self.asteroid_type]["images"][2]
  self.seeded = true
end

function Asteroid.update(self, dt)
  if self.seeded == true then
    for kr, vr in pairs(self.resources) do
	if vr > 0 then
	  self.resources[kr] = self.resources[kr] * 0.999999
	  self.collected[kr] = self.collected[kr] + (self.resources[kr] * 0.000001)

	end
    end
  end
end

function Asteroid.send_package(self)
  local total_resources = 0
  for i, v in pairs(self.collected) do
    total_resources = total_resources + v
  end
  if total_resources >= 30 then
    can = Can.new(self.body:getX() + 50, self.body:getY() + 50, 0, 0, self.collected, self.world)
    self.collected = {
	  iron=0,
	  silicate=0,
	  water=0,
	  phosphate=0,
	  carbon=0
    }
    return can
  end
  return nil
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

function Asteroid.coll(self, obj)
  if obj.name == 'Seed' then
    self.seedit(self)
    obj.consumed = true
  end
end

return Asteroid
