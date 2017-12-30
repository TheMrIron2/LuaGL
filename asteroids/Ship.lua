------------------------------------------------------
-- Ship
------------------------------------------------------

Ship = Thing:clone()
Ship._collidables = {}

function Ship:init()
  Thing.init(self)
  self._collidables[Bullet] = 1
  self._collidables[Asteriod] = 1
  self._collidables[Saucer] = 1
  self._position:x_y_(200, 250)
  self._velocity:x_y_(0, 0)
  self._rotationSpeed = 0
  self._scale = 15
  self._fireTimer = 0

  self._downButtons = {}

  -- reset vibration 
  rpc.padSetActDirect(0, 0, 0);

  return self
end

function Ship:draw()
    gl.Color(.5,.5,1,.8)
  if self._t < 100 then
    gl.Color(.5,.5, 1, (self._t/100))
  end
  gl.Rotate(-90, 0, 0, 1)
  gl.Begin("LINE_LOOP")
  gl.Vertex( 0,  1, 0)
  gl.Vertex( 1, -1, 0)
  gl.Vertex( 0,  0, 0)
  gl.Vertex(-1, -1, 0)
  gl.Vertex(0, 1, 0) -- added because line_loop is actually a line_stipple
  gl.End() 

  gl.Color(.6,.6,1,1)
  gl.PointSize(1)
  gl.Begin("POINTS")
  gl.Vertex( 0,  1, 0)
  gl.Vertex( 1, -1, 0)
  gl.Vertex( 0,  0, 0)
  gl.Vertex(-1, -1, 0)
  gl.End() 
  return self
end

function Ship:skey(skey, x, y)
  print("skey = "..skey)

  if skey == GLUT_KEY_UP then -- thrust
  elseif skey == GLUT_KEY_RIGHT then -- right
  elseif skey == GLUT_KEY_DOWN and self._t > 5 then -- back
  elseif skey == GLUT_KEY_LEFT then -- left
  end
end

function Ship:key(k, x, y)
  -- print("Ship:key("..k..")")
  self._downButtons[k] = 1
end

function Ship:keyup(k, x, y)
  -- print("Ship:keyup("..k..")")
  self._downButtons[k] = nil
end

function Ship:timeStep()
  Thing.timeStep(self)
  self._rotationSpeed = self._rotationSpeed *.9
  self._velocity:scaleBy_(.99)

  local downButtons = self._downButtons

  if downButtons["UP"] then -- thrust
    local f = .1
    self._velocity._x = self._velocity._x + math.cos(self._rotation * 0.0174582925)*f
    self._velocity._y = self._velocity._y + math.sin(self._rotation * 0.0174582925)*f
  end
  if downButtons["LEFT"] then -- right
    self._rotationSpeed = self._rotationSpeed - 1
  end
  if downButtons["CROSS"] and self._fireTimer > 5 then -- shoot
    self. _fireTimer = 0
    local bullet = Bullet:clone():init()
    bullet._tmax = 100
    bullet._position:copyFrom_(self._position)
    --bullet._velocity:copyFrom_(self._velocity)
    bullet._velocity:x_(4)
    bullet._velocity:rotate_(self._rotation * 0.0174582925)
    bullet:timeStep()
    bullet:timeStep()
    bullet:timeStep()
    bullet:timeStep()
    bullet:timeStep()
    bullet:timeStep()
    self:space():add_(bullet)
  end
  if downButtons["RIGHT"] then -- left
    self._rotationSpeed = self._rotationSpeed + 1
  end
  self._fireTimer = self._fireTimer + 1
  return self
end

function Ship:doCollisionWith_(thing)
  self:explode()._size = self._scale * 5 
  self:explode()._size = self._scale * 7 
  self:explode()._size = self._scale * 3 

  -- begin vibration 
  rpc.padSetActDirect(0, 0, 1);
  self:destroy()
end


