local Craft = {}

Craft.__index = Craft

function Craft.new(x, y, mass, world)
  local self = setmetatable({}, Craft)
  self.name = 'Craft'
  self.x = x
  self.y = y
  self._x = x
  self._y = y
  self.ammo = 100
  self.fuel = 100
  self.seeds = 10
  self.water = 0
  self.iron = 0
  self.phosphate = 0
  self.silicate = 0
  self.carbon = 0
  self.mass = mass
  self.world = world
  self.rotation = 0
  self.body = love.physics.newBody(self.world, self.x, self.y, "dynamic")
  self.shape = love.physics.newRectangleShape(0, 0, 50, 27)
  self.fixture = love.physics.newFixture(self.body, self.shape, self.mass)
  self.fixture:setUserData(self)
  self.image = love.graphics.newImage("images/rocket-stop.png")
  return self
end

function Craft.update(self, dt)
  -- print(self.x, self._x, self.y, self._y)
  self.x = self.body:getX()
  self.y = self.body:getY()
  if self.x > 1230 or self.y > 670  or self.x < 50 or self.y < 50 then
    self.world:translateOrigin(self.x - self._x, self.y - self._y)
  end
  self._x = self.body:getX()
  self._y = self.body:getY()
  if love.keyboard.isDown("right") then
    self.rotation = self.rotation + 0.05
  elseif love.keyboard.isDown("left") then
    self.rotation = self.rotation - 0.05
  elseif love.keyboard.isDown("up") then
    if self.fuel > 0 then
      self.fuel = self.fuel - 0.01
      self.body:applyForce(100 * math.cos(self.rotation), 100 * math.sin(self.rotation))
      self.image = love.graphics.newImage("images/rocket.png")
    end
  elseif love.keyboard.isDown("up") ~= true then
    self.image = love.graphics.newImage("images/rocket-stop.png")
  end
end

function Craft.draw(self)
  self.body:setAngle(self.rotation)
  love.graphics.draw(
    self.image, 
    self.body:getX(),
    self.body:getY(), self.body:getAngle(),
    1, 1,
    self.image:getWidth() / 2,
    self.image:getHeight() / 2
  )
  str = string.format("H20: %d, Fe: %d, Si: %d, P: %d, Fuel: %d, Seeds: %d", self.water, self.iron, self.silicate, self.phosphate, self.fuel, self.seeds)
  love.graphics.print({{0, 1, 0}, str}, 0, 60)
end

function Craft.coll(self, obj)
  local o = obj
  if o.name == 'Can' then
    self.phosphate = self.phosphate + o.phosphate
    self.water = self.water + o.water
    self.iron = self.iron + o.iron
    self.carbon = self.carbon + o.carbon
    self.silicate = self.silicate + o.silicate
    o.consumed = true
    o.water = 0
    o.iron = 0
    o.phosphate = 0
    o.silicate = 0
    o.carbon = 0
  end
end

return Craft
