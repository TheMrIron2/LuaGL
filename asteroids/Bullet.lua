------------------------------------------------------
-- Bullet
------------------------------------------------------

Bullet = Thing:clone()
Bullet._collidables = {}

function Bullet:init()
  self._collidables[Asteriod] = 1
  self._collidables[Ship] = 1
  self._collidables[Saucer] = 1
  Thing.init(self)
  self._tmax = 50
  self._scale = .5
  self._position:x_y_(0, 0)
  self._velocity:x_y_(0, 0)
  self._rotationSpeed = 20 --(math.random()-.5)*10
  return self
end

function Bullet:display()
  gl.PushMatrix()
  gl.Translate(self._position._x, self._position._y, 0)
  self:draw()
  gl.PopMatrix()
end

function Bullet:draw()
  --glBegin(GL_LINE_LOOP)
  gl.PointSize(3)
  gl.Begin("POINTS")
  --glColor(random(),random(),random(),1)
  gl.Color(0,1.0,0,1)
  gl.Vertex(0, 0, 0)
  gl.End() 
  return self
end

function Bullet:timeStep()
  Thing.timeStep(self)
  if self._t > self._tmax then self:space():remove_(self) end
  return self
end

function Bullet:doCollisionWith_(thing)
  self:destroy()
end
