hid.PS2KbdInit()
scr.init()
scr.printf("Lua Shell\n")
scr.printf("> ")

cmd = ""

while true do
  key = hid.PS2KbdRead()

  if (key) then
    scr.printf (key)  
    cmd = cmd .. key

    if (key == "\n") then

      print ("executing: " .. cmd)
      f = loadstring (cmd)
      cmd = ""
      f()
      print ("> ")

    end
  end

end
