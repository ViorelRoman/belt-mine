local Rope = {}

Rope.__index = Rope

function Rope.new(a, b)
  local self = setmetatable({}, Rope)
  x1, y1 = a.body:getPosition()
  x2, y2 = b.body:getPosition()
  self.joint = love.physics.newRopeJoint(a.body, b.body, x1, y1 - 48, x2, y2 - 150, 300, true)
  return self
end

function Rope.update(self, dt)
end

function Rope.hud(self)
end

function Rope.draw(self)
  love.graphics.line(self.joint:getAnchors())
end

function Rope.keyreleased(self, key)
end

function Rope.keypressed(self, key)
end

function Rope.coll(self, obj)
end

return Rope
