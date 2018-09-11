local Craft = require "spacecraft"
local Asteroid = require "asteroid"
local Station = require "station"

str = ""

math.randomseed(os.time())

function love.load()
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 0, true)
  player = Craft.new(200, 200, 10, world)
  asteroids = {}
  for i = 1, 1000 do
    asteroid = Asteroid.new(math.random(-10000, 10000), math.random(-10000, 10000), 20, math.random(), world)
    table.insert(asteroids, asteroid)
  end
  station = Station.new(640, 360, world)
  background = love.graphics.newImage("background.jpg")
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
  for i, asteroid in pairs(asteroids) do
    asteroid.draw(asteroid)
  end
  fuel_str = string.format("%d", player.fuel)
  love.graphics.print({{0, 1, 0}, "Fuel: ", {1, 0, 0}, fuel_str}, 0, 0)
  sx, sy = player.body:getLinearVelocity()
  speed_str = string.format("%d m/s", math.sqrt(math.pow(sx, 2) + math.pow(sy, 2)))
  love.graphics.print({{0, 1, 0}, "Speed: ", {1, 0, 0}, speed_str}, 0, 20)
  coordinate_str = string.format("%d %d", player.body:getX() - station.body:getX(), player.body:getY() - station.body:getY())
  love.graphics.print({{0, 1, 0}, "Coordinates: ", {1, 0, 0}, coordinate_str}, 0, 40)
end

