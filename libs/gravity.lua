local Gravity = {}

Gravity.__index = Gravity

function Gravity.new(G, world)
  local self = setmetatable({}, Gravity)
  self.world = world
  self.G = G
  return self
end

function Gravity.update(self, dt)
  solved = {}
  bodies_list = self.world:getBodies()
  for i, b in pairs(bodies_list) do
    for j, x in pairs(bodies_list) do
      if i ~= j and solved[{i, j}] == nil then
        m1 = b:getMass()
        m2 = x:getMass()
        x1 = b:getX()
        x2 = x:getX()
        y1 = b:getY()
        y2 = x:getY()
        r2 = math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2)
        F = -1 * self.G * (m1 * m2) / r2
        Fy = F * (y1 - y2) / math.sqrt(r2)
        Fx = F * (x1 - x2) / math.sqrt(r2)
        b:applyForce(Fx, Fy)
	x:applyForce(-1 * Fx, -1 * Fy)
	table.insert(solved, {i, j})
	table.insert(solved, {j, i})
      end
    end
  end
end

return Gravity
