function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  -- Esse comando é utilizado no ZeroBrane Studio(IDE de Lua) com suporte de LOVE
end
function love.draw()
  love.graphics.print("Hello World", 100, 100)
end
