------------------------------------------------------
-- Screen
------------------------------------------------------

Screen = 
{
  _width  = 512,
  _height = 256,
  _text = "Yindo!",
  _textPosition = { _x=1, _y=1 },
  _displayList = nil,
  _backgroundColor = { _r=0, _g=0, _b=0, _a=1 },
  _textColor = { _r=1, _g=1, _b=1, _a=.7 },
  _loaded = 0,
  _count = 0,
  _space = Space:clone():init(),
}

Screen._space:screen_(Screen)
Screen._space:start()

function Screen:clearScreen()
  local c = self._backgroundColor
  gl.ClearColor(c._r, c._g, c._b, c._a)
  gl.Clear("DEPTH_BUFFER_BIT,COLOR_BUFFER_BIT")
end

function Screen:size()
  return self._width/1.5
end


-- taken from dreamgl/contrib/drfreak/demo.c ... for debugging 
rot = 0.0
function Screen:drFreak()
	rot = rot + 0.5
	if(rot >= 360.0) then
		rot = 0.0
	end

	gl.Clear("DEPTH_BUFFER_BIT,COLOR_BUFFER_BIT")
	gl.MatrixMode("MODELVIEW")
	gl.LoadIdentity()
	gl.Translate(0.0, 0.0, -22.0)
	gl.Rotate(rot, 0.0, 1.0, 0.0)

	gl.Rotate(-90.0, 1.0, 0.0, 0.0)
	gl.Rotate(-90.0, 0.0, 0.0, 1.0)

	gl.Begin("TRIANGLES")
	gl.Color(0.0, 0.0, 0.0)

--//	for(i=0 i<md2_num_tris i++)
	i=0
	while (i < (md2_num_tris - 193)) do
		i = i + 1
--		for(i=0; i<md2_num_tris-193; i++)
--			gl.TexCoord(&md2_st[md2_tris[i].i_st[0]*2]) 
			glVertex3fv(md2_xyz[md2_tris[i].i_xyz[0]*3])
--			gl.TexCoord(&md2_st[md2_tris[i].i_st[2]*2]) 
			glVertex3fv(md2_xyz[md2_tris[i].i_xyz[2]*3])
--			gl.TexCoord(&md2_st[md2_tris[i].i_st[1]*2]) 
			glVertex3fv(md2_xyz[md2_tris[i].i_xyz[1]*3])
	end
	gl.End()

end

function Screen:Axes()
	gl.Begin("LINES");
		gl.Color(0.5, 0.1, 0.1);
		gl.Vertex(-1.0, 0.0, 0.0);
		gl.Vertex( 0.0, 0.0, 0.0);
		gl.Color(1.0, 0.1, 0.1);
		gl.Vertex( 0.0, 0.0, 0.0);
		gl.Vertex( 1.0, 0.0, 0.0);

		gl.Color(0.1, 0.5, 0.1);
		gl.Vertex(0.0, -1.0, 0.0);
		gl.Vertex(0.0,  0.0, 0.0);
		gl.Color(0.1, 1.0, 0.1);
		gl.Vertex(0.0,  0.0, 0.0);
		gl.Vertex(0.0,  1.0, 0.0);

		gl.Color(0.1, 0.1, 0.5);
		gl.Vertex(0.0, 0.0, -1.0);
		gl.Vertex(0.0, 0.0,  0.0);
		gl.Color(0.1, 0.1, 1.0);
		gl.Vertex(0.0, 0.0,  0.0);
		gl.Vertex(0.0, 0.0,  1.0);
	gl.End();
end


function Screen:display()
--  print ("Screen:display()\n");
  self:clearScreen()

-- for testing
--  self:Axes()
--  self._space._ship:draw()
--  self:drFreak()
  self._space:draw()

  gl.Flush()
  glut.SwapBuffers()

  buttons = {}
  rpc.padRead(0, 0, buttons)
--  print (buttons)  
--  table.foreach (buttons, print)
  if (buttons) then
	if (self._space._ship) then
		self._space._ship._downButtons = buttons
    end
  end
end

function Screen:enableSmoothing()
  glEnable(GL_CULL_FACE)
  glEnable(GL_BLEND)
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
  glEnable(GL_LINE_SMOOTH)
  glEnable(GL_POINT_SMOOTH)
end

function Screen:disableSmoothing()
  glDisable(GL_CULL_FACE)
  glDisable(GL_BLEND)
  glDisable(GL_LINE_SMOOTH)
end

function Screen:reshape(width, height)
  gl.Viewport(0, 0, width, height)

  gl.MatrixMode('PROJECTION')
  gl.LoadIdentity()

  gl.MatrixMode('MODELVIEW')
  gl.LoadIdentity()
end

function Screen:skey(k, x, y)
  print("Screen:skey("..k..", x, y)")
  self._space:skey(k, x, y)
end
function Screen:key(k, x, y) self._space:key(k, x, y) end
function Screen:keyup(k, x, y) self._space:keyup(k, x, y) end

function Screen:timer(value)
  print("Screen:timer("..value..")")
  print("the display already seems to refresh?")
  -- self:display()
  -- glut.TimerFunc(30, 'timer', value)
end

function Screen:setMatrix()
  gl.MatrixMode("PROJECTION")
  gl.LoadIdentity()
  gl.Ortho(0, self._width, self._height, 0, -1.0 * self._width, self._height)
  gl.MatrixMode("MODELVIEW")

  gl.BlendFunc("SRC_ALPHA", "ONE_MINUS_SRC_ALPHA")

  gl.LoadIdentity()
  gl.Scale(0.2, 0.2, 1)
end

function Screen:CreateWindow() 
	gl.ClearColor(0.0, 0.0, 0.0, 0.0)
	gl.Clear("COLOR_BUFFER_BIT,DEPTH_BUFFER_BIT")
	gl.ShadeModel("FLAT")
	
	gl.MatrixMode("PROJECTION")
	gl.Ortho(0, self._width, self._height, 0, -1.0 * self._width, -1.0 * self._height)
	
--	gl.MatrixMode("MODELVIEW")
--	gl.LoadIdentity()
--	gl.Rotate(30.0, 0.5, 1.0, 0.0)
end

function Screen:start()
  print ("Screen:start()\n")
  glut.Init()
  glut.InitDisplayMode("PAL") -- defaults to auto detect
  glut.InitWindowSize(800, 600)
  glut.DisplayFunc('display')
  glut.IdleFunc('display')
  glut.ReshapeFunc('reshape')
  glut.KeyboardFunc('key')
  glut.KeyboardUpFunc('keyup')
  glut.SpecialFunc('skey')

--  glut.CreateWindow('Lua GL Test Application')
  self:CreateWindow()

  rpc.padPortOpen(0, 0)
  rpc.initializePad(0, 0)

  print ("glut.MainLoop()\n")
  glut.MainLoop()
end

function DrawFrame()
	self:clearScreen()

  -- draw rectangle
  gl.Color( {1, 1, 0, 0.8} )
  gl.Rect(-1,-1,1,1)
  
--------------------------------------------------------
-- Create List That Draws the Circle
--------------------------------------------------------

  planet = 1
  orbit = 2
  pi = 

  gl.NewList(planet, "COMPILE")
    gl.Begin("POLYGON")
      for i=0, 100 do
	cosine = math.cos(i * 2 * math.pi/100.0)
	sine   = math.sin(i * 2 * math.pi/100.0)
print ("cosine: "..cosine.."\n")
print ("sine: "..sine.."\n")
	gl.Vertex(cosine,sine)
      end
    gl.End()
  gl.EndList()

  gl.NewList(orbit, "COMPILE")
    gl.Begin("LINE_LOOP")
      for i=0, 100 do
	cosine = math.cos(i * 2 * math.pi/100.0)
	sine   = math.sin(i * 2 * math.pi/100.0)
print ("cosine: "..cosine.."\n")
print ("sine: "..sine.."\n")
	gl.Vertex(cosine, sine)
      end
    gl.End()
  gl.EndList()

--------------------------------------------------------

  gl.Color( {0, 0.5, 0, 0.8} )
  gl.CallList(planet)

  gl.Color( {0, 0, 0, 1} )
  lists = { orbit }
  gl.CallLists(lists)

  gl.EnableClientState ("VERTEX_ARRAY")
  
  vertices  = { {-3^(1/2)/2, 1/2}, {3^(1/2)/2, 1/2}, {0, -1}, {-3^(1/2)/2, -1/2}, {3^(1/2)/2, -1/2}, {0, 1} }
    
  gl.VertexPointer  (vertices)
  
  -- draw first triangle
  gl.Color( {0, 0, 1, 0.5} )

  gl.Begin("TRIANGLES")
    gl.ArrayElement (0)
    gl.ArrayElement (1)
    gl.ArrayElement (2)
  gl.End()

  -- draw second triangle
  gl.Color( {1, 0, 0, 0.5} )
  gl.VertexPointer  (vertices)
  gl.DrawArrays("TRIANGLES", 3, 3)

  -- draw triangles outline
  gl.Color(1,1,1,1)
  elements = { 0, 1, 2}   gl.DrawElements("LINE_LOOP", elements)
  elements = { 3, 4, 5}   gl.DrawElements("LINE_LOOP", elements)

  gl.DisableClientState ("VERTEX_ARRAY")

  gl.PopMatrix()
  gl.Translate(0.75,0.5, 0)
  gl.Scale(0.2, 0.2, 1)

  ----------------------------------------------------------------------------

  gl.BlendFunc("SRC_ALPHA", "ONE_MINUS_SRC_ALPHA")

  -- draw rectangle
  gl.Color( {1, 1, 0, 0.8} )
  
  gl.Begin("QUADS")
    gl.Vertex(-1,-1)
    gl.Vertex( 1,-1)
    gl.Vertex( 1, 1)
    gl.Vertex(-1, 1)
  gl.End()
-------------------------------
  gl.Color( {0, 0.5, 0, 0.8} )
  gl.Begin("POLYGON")
    for i=0, 100 do
      cosine = math.cos(i * 2 * math.pi/100.0)
      sine   = math.sin(i * 2 * math.pi/100.0)
      gl.Vertex(cosine,sine)
    end
  gl.End()

  gl.Color( {0, 0, 0, 1} )
  gl.Begin("LINE_LOOP")
    for i=0, 100 do
      cosine = math.cos(i * 2 * math.pi/100.0)
      sine   = math.sin(i * 2 * math.pi/100.0)
      gl.Vertex(cosine, sine)
    end
  gl.End()

  -- draw first triangle
  gl.Color( {0, 0, 1, 0.5} )
  gl.Begin("TRIANGLES")
    gl.Vertex (vertices[1])
    gl.Vertex (vertices[2])
    gl.Vertex (vertices[3])
  gl.End()
  -- draw second triangle
  gl.Color( {1, 0, 0, 0.5} )
  gl.Begin("TRIANGLES")
    gl.Vertex (vertices[4])
    gl.Vertex (vertices[5])
    gl.Vertex (vertices[6])
  gl.End()
  -- draw triangles outline
  gl.Color(1,1,1,1)
  gl.Begin("LINE_LOOP")
    gl.Vertex (vertices[1])
    gl.Vertex (vertices[2])
    gl.Vertex (vertices[3])
  gl.End()
  gl.Begin("LINE_LOOP")
    gl.Vertex (vertices[4])
    gl.Vertex (vertices[5])
    gl.Vertex (vertices[6])
  gl.End()

  glut.SwapBuffers()
  gl.Flush()

end
