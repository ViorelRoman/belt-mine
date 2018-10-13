local Craft = require "models.spacecraft"
local Asteroid = require "models.asteroid"
local Station = require "models.station"
local Can = require "models.goods"
local Seed = require "models.seed"
local Gravity = require "libs.gravity"
local Moan = require "libs.Moan"
local Map = require "models.map"
local Camera = require "libs.camera"

str = ""

math.randomseed(os.time())

function love.load()
  love.physics.setMeter(1)
  world = love.physics.newWorld(0, 0, true)
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)
  gravity = Gravity.new(0.02, world)
  entities = {
    player = {Craft.new(200, 200, 10, world)},
    ropes = {},
    asteroids = {},
    cans = {},
    seeds = {},
    station = {Station.new(640, 480, world)},
    maps = {Map.new()},
  }
  for i = 1, 100 do
    type_chances = math.random()
    if type_chances < 0.5 then
      asteroid_type = 'S'
    elseif type_chances < 0.85 then
      asteroid_type = 'C'
    else
      asteroid_type = 'M'
    end
    asteroid = Asteroid.new(math.random(-4000, 4000), math.random(-4000, 4000), 20, math.random(), asteroid_type, world)
    table.insert(entities.asteroids, asteroid)
  end
  background = love.graphics.newImage("images/background.jpg")
  love.window.setMode(1280, 720)
  Moan.font = love.graphics.newFont("assets/Pixel UniCode.ttf", 32)
  Moan.speak(
    "Приветствую, пилот!",
    {
      "Четвертая мировая война уничтожила человечество и его колонии на Луне и Марсе",
      "Наша станция в поясе Койпера - единственное что осталось от нашего вида. Обезумевшие военные пытались уничтожить и ее, послав кинетический снаряд, разрушивший Плутон и Харон, вокруг которых станция вращалась...",
      "И это дало нам шанс выжить. Осколки бывшей карликовой планеты и ее спутника образовали компактное облако астероидов, которые мы можем эксплоатировать, добывая воду, органику, металы и силикаты для нашей жизни и нашего оборудования",
      "Ты, мой друг, пилот единственного шатла который есть у нас в распоряжении. От твоих умений зависит выживание всего человеческого рода, так что будь осторожен - если ты не сможешь вернуться на станцию, то потеряешь не только свою жизнь.",
      "А теперь дерзай"
    }
  )
  camera = Camera(1280 / 2, 720 / 2)
end

function check_and_destroy()
  for i, group in pairs(entities) do
    tbl = {}
    for j, obj in pairs(group) do
      if obj.consumed == true then
        obj.body:destroy()
        obj = nil
      else
	table.insert(tbl, obj)
      end
    end
    entities[i] = tbl
  end
end

function love.update(dt)
  world.update(world, dt)
  for i, body in pairs(world:getBodies()) do
    f = body:getFixtures()[1]
    obj = f:getUserData()
    obj.update(obj, dt)
  end
  gravity.update(gravity, dt)
  Moan.update(dt)
  check_and_destroy()
end

function love.keyreleased(key)
  for i, group in pairs(entities) do
    for j, obj in pairs(group) do
      obj.keyreleased(obj, key)
    end
  end
  Moan.keyreleased(key)
end

function love.keypressed(key)
  for i, group in pairs(entities) do
    for j, obj in pairs(group) do
      obj.keypressed(obj, key)
    end
  end
  Moan.keyreleased(key)
end

function love.draw()
  love.graphics.draw(background, 0, 0)
  camera:attach()
  for i, group in pairs(entities) do
    for j, obj in pairs(group) do
      obj.draw(obj)
    end
  end
  camera:detach()
  for i, group in pairs(entities) do
    for j, obj in pairs(group) do
      obj.hud(obj)
    end
  end
  Moan.draw()
end

function beginContact(a, b, coll)
end

function endContact(a, b, coll)
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll, n, t)
  obj_a = a:getUserData()
  obj_b = b:getUserData()
  obj_a:coll(obj_b)
  obj_b:coll(obj_a)
end
