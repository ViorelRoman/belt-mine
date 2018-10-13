local Station = {}

Station.__index = Station

function Station.new(x, y, world)
  self = setmetatable({}, Station)
  self.name = 'Station'
  self.x = x
  self.y = y
  self.world = world
  self.body = love.physics.newBody(self.world, x, y, "dynamic")
  self.shape = love.physics.newCircleShape(152)
  self.fixture = love.physics.newFixture(self.body, self.shape, 100000)
  self.fixture:setUserData(self)
  self.body:setAngularVelocity(0.05)
  self.image = love.graphics.newImage("images/station.png")
  self.water = 100
  self.food = 100
  self.iron = 100
  self.silicate = 100
  self.carbon = 100
  self.phosphate = 100
  self.seeds = 10
  self.fuel = 100
  self.technologies = {}
  self.humans = 100
  self.infrastructure = {
    greenhouse=2,
    insect_farm=10
  }
  self.live_support = {
    o2=100,
    co2=1
  }
  return self
end

function Station.setMass(self)
  mass = 150000 + self.water + self.food + self.iron + self.silicate + self.carbon + self.phosphate + self.seeds + self.fuel
  self.body:setMass(mass)
  -- print(mass)
end

function Station.update(self, dt)
  self.water = self.water - 0.001
  self.carbon = self.carbon - 0.0005
  self.iron = self.iron - 0.001
  self.silicate = self.silicate - 0.0005
  self.phosphate = self.phosphate - 0.0001
  self.fuel = self.fuel + 0.0009
  self.seeds = self.seeds + 0.00009
  self.setMass(self)
end

function Station.hud()
  str = string.format("H20: %d, Fe: %d, Si: %d, P: %d, Fuel: %d, Seeds: %d", self.water, self.iron, self.silicate, self.phosphate, self.fuel, self.seeds)
  love.graphics.print({{0, 1, 0}, str}, 0, 680)
end

function Station.draw()
  love.graphics.draw(
    self.image, 
    self.body:getX(),
    self.body:getY(), self.body:getAngle(),
    1, 1,
    self.image:getWidth() / 2,
    self.image:getHeight() / 2
  )
end

function Station.coll(self, o)
  if o.name == 'Craft' then
    for k, v in pairs(o.resources) do
	self[k] = self[k] + v
	o.resources[k] = 0
    end
    need_fuel = math.min(30 - o.fuel, self.fuel)
    self.fuel = self.fuel - need_fuel
    o.fuel = o.fuel + need_fuel
    need_seeds = math.min(10 - o.seeds, self.seeds)
    o.seeds = o.seeds + need_seeds
    self.seeds = self.seeds - need_seeds
  end
  if o.name == 'Can' then
    for k, v in pairs(o.resources) do
      self[k] = self[k] + o.resources[k]
      o.resources[k] = 0
    end
    o.consumed = true
  end
end

function Station.keypressed(self, key)
end

function Station.keyreleased(self, key)
  if key == 'h' then
    camera:lookAt(self.body:getPosition())
  end
end

return Station
