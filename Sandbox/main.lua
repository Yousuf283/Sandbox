require 'Core'

love.load = function()
  Load()
end

love.update = function(dt)
  Update(dt)
end

love.draw = function()
  Draw()
end

love.keypressed = function(k)
  KeyPressed(k)
end

love.mousepressed = function(x,y,b)
  MousePressed(x,y,b)
end
love.mousemoved = function(x,y,dx,dy)
  MouseMoved(dx,dy)
end