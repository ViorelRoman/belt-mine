local Station = {}

Station.__index = Station

function Station.new(x, y, world)
  self = setmetatable({}, Station)
  self.x = x
  self.y = y
  self.world = world
  self.body = love.physics.newBody(self.world, x, y, "dynamic")
  self.shape = love.physics.newCircleShape(152)
  self.fixture = love.physics.newFixture(self.body, self.shape, 100000)
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
  return self
end

function Station.update(dt)
  self.water = self.water - 0.001
  self.carbon = self.carbon - 0.0005
  self.iron = self.iron - 0.001
  self.silicate = self.silicate - 0.0005
  self.phosphate = self.phosphate - 0.0001
  self.fuel = self.fuel + 0.0009
  self.seeds = self.seeds + 0.00009
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
  str = string.format("H20: %d, Fe: %d, Si: %d, P: %d, Fuel: %d, Seeds: %d", self.water, self.iron, self.silicate, self.phosphate, self.fuel, self.seeds)
  love.graphics.print({{0, 1, 0}, str}, 0, 680)
end

return Station
