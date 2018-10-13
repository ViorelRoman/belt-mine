local Map = {}

Map.__index = Map

function Map.new()
  local self = setmetatable({}, Map)
  return self
end

function Map.update(self, dt)
end

function Map.hud(self)
  local w = 200
  local h = 200
  local x = 1280 - w
  local y = 0
  love.graphics.setColor(0, 0, 0, 0.1)
  love.graphics.rectangle('fill', x, y, w, h)
  player = entities.player[1]
  x1, y1 = player.body:getPosition()
  -- show the spacecraft
  love.graphics.setColor(0, 1, 0)
  love.graphics.circle('fill', x + (w / 2), y + (h / 2), 2)
  -- draw asteroids
  love.graphics.setColor(1, 0, 0)
  for i, a in pairs(entities.asteroids) do
    x2, y2 = a.body:getPosition()
    -- d, x1, x2, y1, y2 = love.physics.getDistance(player.fixture, a.fixture)
    love.graphics.circle('fill', x - ((x1 - x2) * 200 / 8000) + (w / 2), y - ((y1 - y2) * 200 / 8000) + (h / 2), 2)
  end
  -- show the station
  love.graphics.setColor(0, 0, 1)
  station = entities.station[1]
  x2, y2 = station.body:getPosition()
  love.graphics.circle('fill', x - ((x1 - x2) * 200 / 8000) + (w / 2), y - ((y1 - y2) * 200 / 8000) + (h / 2), 3)
  -- restore the default color
  love.graphics.setColor(1, 1, 1)
end

function Map.draw(self)
end

function Map.keyreleased(self, key)
end

function Map.keypressed(self, key)
end

return Map
