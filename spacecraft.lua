local Craft = {}

Craft.__index = Craft

function Craft.new(x, y, mass, world)
  local self = setmetatable({}, Craft)
  self.x = x
  self.y = y
  self._x = x
  self._y = y
  self.ammo = 100
  self.fuel = 100
  self.mass = mass
  self.world = world
  self.rotation = 0
  self.body = love.physics.newBody(self.world, self.x, self.y, "dynamic")
  self.shape = love.physics.newRectangleShape(0, 0, 50, 27)
  self.fixture = love.physics.newFixture(self.body, self.shape, self.mass)
  self.image = love.graphics.newImage("rocket-stop.png")
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
      self.image = love.graphics.newImage("rocket.png")
    end
  elseif love.keyboard.isDown("up") ~= true then
    self.image = love.graphics.newImage("rocket-stop.png")
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
end

return Craft
