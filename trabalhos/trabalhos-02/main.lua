function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end 
  -- utilizando esse comando pois estou usando ZeroBrane Studio para debuggar o programa
end
function love.draw()
  love.graphics.print("Hello World", 100, 100)
end
