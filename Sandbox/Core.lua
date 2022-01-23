local g3d = require('g3d')

local MouseLock = true
local Mode = 'Build'
local Blocks = {}
local ColourData = {}

local Colours = {
  {181/255, 101/255, 30/255, 1}, --Brown
  {247/255, 233/255, 72/255, 1}, --Yellow
  {174/255, 173/255, 13/255, 1}, --Dark_Yellow
  {198/255, 47/255, 36/255, 1}, --Red 
  {1,1,1,1}, --White
  {0,0,0,1} --Black
}

local CurrentColour = Colours[1]

Load = function()
  
end

Update = function(dt)
  g3d.camera.firstPersonMovement(dt)
  if not MouseLock then
    love.mouse.setRelativeMode(false)
  else
    love.mouse.setRelativeMode(true)
  end
end

Draw = function()
  love.graphics.setBackgroundColor(0.5,0.5,0.5,1)
  love.graphics.setColor(64/255, 139/255, 230/255, 1)
  love.graphics.rectangle('fill',0,0,100,600)
  love.graphics.setColor(1,1,1,1)
  
  if #Blocks ~= nil then
    for i = 1,#Blocks do
      love.graphics.setColor(ColourData[i])
      Blocks[i][1]:draw()
    end
  end
  
  for i = 1,#Colours do
    love.graphics.setColor(Colours[i])
    love.graphics.rectangle('fill', (75/2)-12.5, i*50,50,25)
    love.graphics.setColor(1,1,1,1)
  end
  
end

KeyPressed = function(k)
  if k == 'escape' then love.event.quit() end
  if k == 'c' then
    Blocks = {}
    ColourData = {}
  elseif k == 'r' then
    table.remove(Blocks)
    table.remove(ColourData)
  end
end

MousePressed = function(x,y,b)
  if b == 2 then
    MouseLock = not MouseLock
  end
  if MouseLock then
    if b == 1 then
      table.insert(Blocks,{g3d.newModel('Models/Cube.obj', nil, {math.floor((g3d.camera.position[1]+5)+0.5),math.floor(g3d.camera.position[2]),math.floor(g3d.camera.position[3])}, nil, {1,1,1})})
      table.insert(ColourData,CurrentColour)
    end
  elseif not MouseLock then
    if b == 1 then
      for i = 1,#Colours do
        if x >= (75/2)-12.5 and x <= (((75/2)-12.5)+50) and y >= (i*50) and y <= ((i*50)+25) then
          CurrentColour = Colours[i]
        end
      end
    end
  end
end

MouseMoved = function(dx,dy)
  if MouseLock then
    g3d.camera.firstPersonLook(dx,dy)
  end
end