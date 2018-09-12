local Craft = require "models.spacecraft"
local Asteroid = require "models.asteroid"
local Station = require "models.station"
local Can = require "models.goods"

str = ""

math.randomseed(os.time())

function love.load()
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 0, true)
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)
  player = Craft.new(200, 200, 10, world)
  asteroids = {}
  for i = 1, 1000 do
    type_chances = math.random()
    if type_chances < 0.5 then
      asteroid_type = 'S'
    elseif type_chances < 0.85 then
      asteroid_type = 'C'
    else
      asteroid_type = 'M'
    end
    asteroid = Asteroid.new(math.random(-10000, 10000), math.random(-10000, 10000), 20, math.random(), asteroid_type, world)
    table.insert(asteroids, asteroid)
  end
  can = Can.new(math.random(0, 1280), math.random(0, 720), math.random(), math.random(), world)
  station = Station.new(640, 360, world)
  background = love.graphics.newImage("images/background.jpg")
  love.window.setMode(1280, 720)
end

function love.update(dt)
  world.update(world, dt)
  player.update(player, dt)
  station.update(station, dt)
end

function love.draw()
  love.graphics.draw(background, 0, 0)
  player.draw(player)
  station.draw(station)
  if can ~= nil then
    if can.consumed then
      can.body:destroy()
      can = nil
    else
      can.draw(can)
    end
  end
  for i, asteroid in pairs(asteroids) do
    asteroid.draw(asteroid)
  end
  fuel_str = string.format("%d", player.fuel)
  love.graphics.print({{0, 1, 0}, "Fuel: ", {1, 0, 0}, fuel_str}, 0, 0)
  sx, sy = player.body:getLinearVelocity()
  speed_str = string.format("X: %d m/s, Y: %d m/s, Total: %d m/s", sx, sy, math.sqrt(math.pow(sx, 2) + math.pow(sy, 2)))
  love.graphics.print({{0, 1, 0}, "Speed: ", {1, 0, 0}, speed_str}, 0, 20)
  coordinate_str = string.format("%d %d", player.body:getX() - station.body:getX(), player.body:getY() - station.body:getY())
  love.graphics.print({{0, 1, 0}, "Coordinates: ", {1, 0, 0}, coordinate_str}, 0, 40)
end

function beginContact(a, b, coll)
  obj_a = a:getUserData()
  obj_b = b:getUserData()
  obj_a:coll(obj_b)
  obj_b:coll(obj_a)
end

function endContact(a, b, coll)
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll, n, t)
end
