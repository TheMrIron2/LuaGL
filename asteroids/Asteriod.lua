------------------------------------------------------
-- Asteriod
------------------------------------------------------

Asteriod = Thing:clone()
Asteriod._generation = 1
Asteriod._collidables = {}



function Asteriod:init()
  --self._collidables = {}
  self._collidables[Bullet] = 1
  self._collidables[Ship] = 1
  self._collidables[Saucer] = 1
  self._proto = Asteriod
  Thing.init(self)
  self._position:x_y_(2000*math.random(), 2000*math.random())
  self._velocity:x_y_(math.random()-.5, math.random()-.5)
  self._rotationSpeed = math.random()-.5
  return self
end

function Asteriod:draw()
  gl.Color(1,1,1, .7)
  if self._t < 3 then
    gl.Color(1,.5,.5, 1)
  end

  gl.Begin("LINE_LOOP")
  gl.Vertex( -1,  0, 0)
  gl.Vertex( -1, .4, 0)
  gl.Vertex(-.5,  1, 0)
  gl.Vertex(  0, .4, 0)
  gl.Vertex( .7, .4, 0)
  gl.Vertex(  1,  0, 0)
  gl.Vertex( .6,-.5, 0)
  gl.Vertex(-.2, -1, 0)
  gl.Vertex(-1, 0, 0) -- added because line_loop is actually a line_stipple
  gl.End() 

  gl.Color(1,1,1, .6)
  gl.PointSize(1)
  gl.Begin("POINTS")
  gl.Vertex( -1,  0, 0)
  gl.Vertex( -1, .4, 0)
  gl.Vertex(-.5,  1, 0)
  gl.Vertex(  0, .4, 0)
  gl.Vertex( .7, .4, 0)
  gl.Vertex(  1,  0, 0)
  gl.Vertex( .6,-.5, 0)
  gl.Vertex(-.2, -1, 0)
  gl.End() 
  return self
end

function Asteriod:build()
  self._spoke[i] = math.random()
  return self
end

function Asteriod:collideWith_(thing)
  self._t = 0

  if self._collidables[thing._proto] == 1 or 
    ( thing._proto == Explosion and math.random() < .01 ) then
    if self._generation < 3 then
      local spawn1 = self:spawn()
      if math.random() > .1 then 
        local spawn2 = self:spawn()
        spawn2._velocity:copyFrom_(spawn1._velocity):negate()
      end
    end
    self:explode()
    self:destroy()
  end
end

function Asteriod:spawn()
  local newObj = self:clone():init()
  newObj._position:copyFrom_(self._position)
  newObj._scale = self._scale*.6*(1-(math.random()-.5)/2)
  newObj._generation = self._generation + 1
  newObj._velocity:random():scaleBy_(2*self._generation)
  newObj._rotation = math.random()*360
  newObj._rotationSpeed = math.random()*10*self._generation
  newObj:timeStep()
  newObj:timeStep()
  newObj:timeStep()
  newObj:timeStep()
  newObj:create()
  return newObj
end

