function love.load()
  -- variables for game
  gameState = 0 -- 0 for main menu, 1 for in a game mode, add game state definitions here
  gameMode = 0 -- 0 for english, 1 for maths, 2 for science
  
  -- variables for player
  pState = 0 -- 0 for standing, 1 for jumping, 2 for falling, add player state definitions here
  pSprite = 0 -- sprite from spritesheet player is on on current frame
  pSpeed = 3 -- constant; player's speed
  pGround = love.graphics.getHeight() -- height of the ground the player is currently over
  pWidth = 50 -- constant; player's width
  pHeight = 50 -- constant; player's height
  pX = 100 -- player's x co-ordinate
  pY = pGround - pHeight -- player's y co-ordinate
  pDirection = 1 --  for left, 1 for right
  pJumpHeight = 20 -- constant; pixels the player rises in the first frame of a jump
  pGravity = 2 -- constant; force due to gravity acting on player
  pHeightFromJump = 0 -- pixels player is rising on current frame
  pMovingLeft = false -- true if player is being instructed to move left
  pMovingRight = false -- true if player is being instructed to move right
  pFrames = 0 -- player's frame counter
  pImage = love.graphics.newImage("sprites/Placeholder1.png")
  pQuad = love.graphics.newQuad(0, 0, pWidth, pHeight, pImage:getWidth(), pImage:getHeight())
  
  -- variables for platforms
  platforms = {}
  platformImage = love.graphics.newImage("sprites/Placeholder2.png")
  
  platform = {} -- new platform
  platform.Width = platformImage:getWidth() -- constant; player's width
  platform.Height = platformImage:getHeight() -- constant; player's height
  platform.X = 200 -- platform's x co-ordinate
  platform.Y = love.graphics.getHeight() - platform.Height -- platform's y co-ordinate
  platform.GroundFound = false -- used for ground check
  table.insert(platforms, platform)
end

function love.mousepressed(x, y, button, isTouch)
  if x < 160 then -- move left
    pMovingLeft = true
  elseif x >= 320 then -- move right
    pMovingRight = true
  else -- jump
    if pY == pGround - pHeight then
      pState = 1
      pHeightFromJump = 15
    end
  end
end

function love.mousereleased(x, y, button, isTouch)
  pMovingLeft = false
  pMovingRight = false
end

function love.update(dt)
  CheckGround()
  PlayerMove()
  PlayerJump()
  PlayerFall()
  CheckLeftWalls()
  CheckRightWalls()
end

function love.draw()
  for i,v in ipairs(platforms) do
    love.graphics.draw(platformImage, v.X, v.Y)
  end
  love.graphics.draw(pImage, pQuad, pX, pY)
end

function CheckGround() -- function finds height of ground beneath the player and decides if the player has fallen off a platform
  for i,v in ipairs(platforms) do
    if pX > v.X - pWidth then
      if pX < v.X + v.Width then
        v.GroundFound = true
      end
    end
    
    if v.Y < pY + pHeight then
      v.GroundFound = false
    end
  end
  
  local ground = love.graphics.getHeight()
  for i,v in ipairs(platforms) do
    if v.GroundFound then
      if v.Y < ground then
        ground = v.Y
      end
    end
    v.GroundFound = false
  end
  pGround = ground
  
  if pY + pHeight < pGround then
    if pState ~= 1 then
      pState = 2
    end
  end
end

function PlayerMove() -- function moves player left or right
  if pMovingLeft then
    pX = pX - pSpeed
  end
  if pMovingRight then
    pX = pX + pSpeed
  end
end

function PlayerJump() -- function makes player rises after a jump input
  if pState == 1 then
    pY = pY - pHeightFromJump
    pHeightFromJump = pHeightFromJump - 1
    if pHeightFromJump <= 0 then
      pState = 2
    end
  end
end

function PlayerFall() -- function makes player fall after falling off a ledge or reaching the peak of it's jump and makes the player land
  if pState == 2 then
    pY = pY - pHeightFromJump
    pHeightFromJump = pHeightFromJump - 1
    if pY >= pGround - pHeight then
      pHeightFromJump = 0
      pState = 0
      pY = pGround - pHeight
    end
  end
end

function CheckLeftWalls() -- function stops a player from passing through a platform's left wall
  for i,v in ipairs(platforms) do
    local hitTest = CheckCollision(v.X, v.Y + 1, 1, v.Height - 2, pX, pY, pWidth, pHeight)
    if hitTest then
      pX = v.X - pWidth
    end
  end
end

function CheckRightWalls() -- function stops a player from passing through a platform's right wall
  for i,v in ipairs(platforms) do
    local hitTest = CheckCollision(v.X + v.Width - 1, v.Y + 1, 1, v.Height - 2, pX, pY, pWidth, pHeight)
    if hitTest then
      pX = v.X + v.Width
    end
  end
end

function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2) -- function performs a collision check and returns a bool
  return x1 < x2 + w2 and
         x2 < x1 + w1 and
         y1 < y2 + h2 and
         y2 < y1 + h1
end