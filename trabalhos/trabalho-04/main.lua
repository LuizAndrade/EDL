local auxiliar = {}

local char = {
  image = nil,
  x     = (love.graphics.getWidth() / 2) - 50,
  y     = (love.graphics.getHeight() - 150),
  w     = 85,
  h     = 90
}

local enemyW = 100
local enemyH = 77

local createEnemyTimerMax = 0.4
local createEnemyTimer    = createEnemyTimerMax

enemies = {}

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

deaths  = 0
isAlive = true
winGame = false

--Nome: Variável "winGame" 
--Propriedade: Endereço
--Binding Time: Compile Time
--Explicação: A variável "winGame" é global e com valor já atribuido,
--            seu espaço na memória será alocada em tempo de compilação.
--            
--            
--            

-------------[[ funções principais ]]--------------

function love.load () -- ibagens

  
  if arg[#arg] == "-debug" then require("mobdebug").start() end

  waterblock = love.graphics.newImage("images/water-block.png")
  grassblock = love.graphics.newImage('images/grass-block.png')
  stoneblock = love.graphics.newImage('images/stone-block.png')
  gameover   = love.graphics.newImage('images/game-over.png')

  enemyImg   = love.graphics.newImage('images/enemy-bug.png')
  char.image = love.graphics.newImage('images/chargirl.png')

  for i=0, 23, 1 do
    newEnemy = { x = math.random()*800, y = math.random()*1000, img = enemyImg } -- inimigos por linha
    table.insert(enemies, newEnemy)
   end
end

function love.draw()
  local numrows = 6
  local numcols = 7

  auxiliar.bg(numrows,numcols)

  if isAlive then
    love.graphics.draw(char.image, char.x, char.y)
  else
    auxiliar.fonte()
    love.graphics.print("THIS PLAYER IS NO MORE! HE HAS CEASED TO BE!",90, 15)
    love.graphics.print("PRESS R/ESC TO RESTART/QUIT", 30, 30)
    love.graphics.print("DEATH COUNT: "..deaths, 450, 30)
    love.graphics.draw(gameover, 0, 150)
    enemies = {}
  end

  if char.y < 50 and isAlive then
    auxiliar.wins()
  end

  for i, enemy in ipairs(enemies) do
    love.graphics.draw(enemy.img, enemy.x, enemy.y)
  end
end
function love.update(dt)


  auxiliar.teclado(dt)

  createEnemyTimer = createEnemyTimer - (1 * dt) -- respawn
  if createEnemyTimer < 0 then
	   createEnemyTimer = createEnemyTimerMax

     newEnemy = { x = -100, y = math.random()*1000, img = enemyImg } -- inimigos por linha
     table.insert(enemies, newEnemy)
   end

  for i, enemy in ipairs(enemies) do -- movimentos do inimigo
    enemy.x = enemy.x + (200 * dt)
  end

  for i, enemy in ipairs(enemies) do
    
  --Nome: "for"
  --Propriedade: Sintaxe
  --Binding Time: Language Design Time
  --Explicação: Dado que "for" é uma palavra reservada de Lua, sua
  --            amarração somente poderia ser feita em tempo de design.
  --            Para a utilização do "for" deve ser respeitadas regras atribuidas à linguagem
  --            como o uso de "then" e "do".
  --            
  
  	if CheckCollision(enemy.x, enemy.y, enemyW, enemyH, char.x, char.y, char.w, char.h)
  	and isAlive then
  		table.remove(enemies, i)
  		isAlive = false
      deaths = deaths + 1
	 --Nome: Operador "+"
        --Propriedade: Valor da Instrução de baixo nível
        --Binding Time: Compile Time
        --Explicação: A instrução de adição varia dependendo dos tipos
        --            entre dois operandos (e.g int, float, long, entre outros).
        --            Desta maneira, a instrução é definida em tempo de compilação.
        
  	end
  end
end

-------------[[ funções auxiliares ]]--------------

auxiliar.bg = function(numrows, numcols) -- texturas do fundo
  for row = 0, numrows do
    for col = 0, numcols do
      if row < 1 then
        love.graphics.draw(waterblock, col * 100, row * 80)
      elseif row < 3 then
        love.graphics.draw(stoneblock, col * 100, row * 80)
      else
        love.graphics.draw(grassblock, col * 100, row * 80)
      end
    end
  end
end

auxiliar.teclado = function(dt) -- movimentos possiveis do jogador
--Nome: "auxiliar.teclado"         
--Propriedade:  Endereço
--Binding Time: Run Time
--Explicação: Quando a função "teclado" for criada, seu endereço será alocado na
--            tabela "auxiliar" em tempo de execução.

  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end

  if love.keyboard.isDown('r') then
    auxiliar.restart()
  end

  if not winGame then
  --Nome: "if" 
  --Propriedade: Sintaxe
  --Binding Time: Language Design Time
  --Explicação: Como em Lua, "if" é uma palavra reservada à linguagem, sua amarração
  --            é feita em tempo de design.
  --            Para o uso do "if" é necessário respeitar regras já impostas na linguagem, como a
  --            utilização de "then" e "end". Caso não seja respeitada o interpretador retornará
  --            um erro, impedindo a compilação.
  --
    
    
    if love.keyboard.isDown('a', 'left')then
      if char.x > 0 then
        char.x = char.x - (dt * 100)
      end
    elseif love.keyboard.isDown('d', 'right')then
      if char.x < (love.graphics.getWidth() - char.image:getWidth()) then
        char.x = char.x + (dt * 100)
      end
    elseif love.keyboard.isDown('w', 'up') then
      if char.y > 0 then
        char.y = char.y - (dt * 100)
      end
    elseif love.keyboard.isDown('s', 'down') then
      if char.y < (love.graphics.getHeight() - char.image:getHeight()) then
        char.y = char.y + (dt * 100)
      end
    end
  end
end

auxiliar.wins = function() -- tela de vitoria
  winGame = true
  auxiliar.fonte()
  love.graphics.print("--YOU DIED--", (love.graphics.getWidth() / 2) - 50, 10)
  love.graphics.print("Life is meaningless, death is a victory. Press R to restart", 25, 25 )
  love.graphics.setColor(255, 0, 0)
  enemies = {}
end

auxiliar.fonte = function() --
  local font = love.graphics.newImageFont("images/Fonte.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
  
  --Nome: Variavel "font"
  --Propriedade: Valor
  --Binding Time: Run Time
  --Explicação: Como "font" é uma variável local e somente é criada e
  --            atribuida quando a função for chamada, seu valor será
  --            determinada em tempo de execução.
  --            
  
  love.graphics.setFont(font)
end

auxiliar.restart = function() -- pe lanza
  char.x = (love.graphics.getWidth() / 2) - 50
  char.y = (love.graphics.getHeight() - 150)
  love.graphics.setColor(255, 255, 255)
  enemies = {}
  createEnemyTimer = createEnemyTimerMax
  isAlive = true
  winGame = false
end
