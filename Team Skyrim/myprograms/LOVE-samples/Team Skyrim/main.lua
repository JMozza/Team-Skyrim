function love.load()
  width = 480
  height = 270
  if love.system.getOS() == "Android" then
    local x, y = love.graphics.getDimensions()
    scaleX = (x/width)
    scaleY = (y/height)
  else
    scaleX = 1
    scaleY = 1
  end
  
  -- variables for game
  gameState = 1 -- 0 for main menu, 1 for in a game mode, 2 for level completion, add game state definitions here
  gameMode = 0 -- 0 for english, 1 for maths, 2 for science
  
  -- variables for player
  pState = 0 -- 0 for standing, 1 for jumping, 2 for falling, add player state definitions here
  pSprite = 0 -- sprite from spritesheet player is on on current frame
  pSpeed = 3 -- constant; player's speed
  pGround = love.graphics.getHeight() -- height of the ground the player is currently over
  pWidth = 25 * scaleX -- constant; player's width
  pHeight = 25 * scaleY-- constant; player's height
  pX = 0 -- player's x co-ordinate
  pY = pGround - pHeight -- player's y co-ordinate
  pDirection = 1 -- 0 for left, 1 for right
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
  
  for i=0,2 do
    platform = {} -- new platform
    platform.Width = platformImage:getWidth() * scaleX-- constant; platform's width
    platform.Height = platformImage:getHeight() * scaleY-- constant; platform's height
    if i == 0 then
      platform.X = love.graphics.getWidth() / 4.8-- platform's x co-ordinate
      platform.Y = love.graphics.getHeight() / 1.22727 -- platform's y co-ordinate
    elseif i == 1 then
      platform.X = love.graphics.getWidth() / 3.2-- platform's x co-ordinate
      platform.Y = love.graphics.getHeight() / 1.58824-- platform's y co-ordinate
    else
      platform.X = love.graphics.getWidth() / 2.4-- platform's x co-ordinate
      platform.Y = love.graphics.getHeight() / 2.25-- platform's y co-ordinate
    end
    platform.GroundFound = false -- used for ground check
    table.insert(platforms, platform)
  end
  
  --variables for collectables
  collectables = {} -- collectables on the screen
  collectableCount = 0 -- amount of collectables
  collectableImage = love.graphics.newImage("sprites/Placeholder3.png")
  
  for i=0,2 do
    collectable = {} -- new collectable
    collectable.Width = collectableImage:getWidth() * scaleX-- constant; collectable's width
    collectable.Height = collectableImage:getHeight() * scaleY-- constant; collectable's height
    if i == 0 then
      collectable.X = love.graphics.getWidth() / 2.4 -- collectable's x co-ordinate
      collectable.Y = love.graphics.getHeight() / 1.22727-- collectable's y co-ordinate
      collectable.Letter = "A" -- letter the collectable represents
    elseif i == 1 then
      collectable.X = love.graphics.getWidth() / 2.4 -- collectable's x co-ordinate
      collectable.Y = love.graphics.getHeight() / 13.5 -- collectable's y co-ordinate
      collectable.Letter = "B" -- letter the collectable represents
    else
      collectable.X = 0 -- collectable's x co-ordinate
      collectable.Y = love.graphics.getHeight() / 2.25-- collectable's y co-ordinate
      collectable.Letter = "C" -- letter the collectable represents
    end
    table.insert(collectables, collectable)
    collectableCount = collectableCount + 1 -- increment collectable count
  end
  
  -- variables for collected letters
  letters = {} -- collected letters
  letterCount = 0 -- amount of letters
  
  love.window.setMode(width * scaleX, height * scaleY)
end

function love.mousepressed(x, y, button, isTouch)
  if y < ((love.graphics.getHeight() / 3) * 2) then
    if x < (love.graphics.getWidth() / 4) then -- move left
      pMovingLeft = true
    elseif x >= ((love.graphics.getWidth() / 4) * 3) then -- move right
      pMovingRight = true
    end
    
    if (x > love.graphics.getWidth() / 4 and x < ((love.graphics.getWidth() / 4) * 3)) then-- jump
      if pY == pGround - pHeight then
        pState = 1
        pHeightFromJump = 20
      end
    end
  else
    if pState == 0 then -- fall through a platform
      pHeightFromJump = -1
      pY = pY - pHeightFromJump
      pState = 2
    end
  end
end

function love.mousereleased(x, y, button, isTouch)
  pMovingLeft = false
  pMovingRight = false
end

function love.touchpressed( id, x, y, dx, dy, pressure )
  if (y * love.graphics.getHeight()) < ((love.graphics.getHeight() / 3) * 2) then
    if (x * love.graphics.getWidth()) < (love.graphics.getWidth() / 4) then -- move left
      pMovingLeft = true
    elseif (x * love.graphics.getWidth()) >= ((love.graphics.getWidth() / 4) * 3) then -- move right
      pMovingRight = true
    end
    
    if(x * love.graphics.getWidth() > love.graphics.getWidth() / 4 and x * love.graphics.getWidth() < ((love.graphics.getWidth() / 4) * 3)) then -- jump
      if pY == pGround - pHeight then
        pState = 1
        pHeightFromJump = 20
      end
    end
  else
    if pState == 0 then -- fall through a platform
      pHeightFromJump = -1
      pY = pY - pHeightFromJump
      pState = 2
    end
  end
end

function love.touchreleased( id, x, y, dx, dy, pressure )
  pMovingLeft = false
  pMovingRight = false
end

function love.update(dt)
  if gameState == 1 then
    CheckGround()
    PlayerMove()
    PlayerJump()
    PlayerFall()
    CheckCollectables()
    CheckLeftWalls()
    CheckRightWalls()
  end
  
  if collectableCount == 0 then
    gameState = 2
  end
end

function love.draw()  
  for i,v in ipairs(platforms) do
    love.graphics.draw(platformImage, v.X, v.Y, 0, 1 * scaleX, 1 * scaleY)
  end
  for i,v in ipairs(collectables) do
    love.graphics.draw(collectableImage, v.X, v.Y, 0, 1 * scaleX, 1 * scaleY)
  end
  love.graphics.draw(pImage, pQuad, pX, pY)
  
    if gameState == 2 then
    for i,v in ipairs(letters) do
      love.graphics.print(v.Letter, (i - 1) * 10, 0) -- letters collected throughout the game display in top left corner once they're all collected
    end
    love.graphics.print("GAME COMPLETE", 100, 100) -- completion message
  else
    love.graphics.print("controls: top left to move left. top middle", 0, 100) -- controls
    love.graphics.print("to jump. top right to move right. bottom to", 0, 120)
    love.graphics.print("fall through platform.", 0, 140)
    love.graphics.print(scaleX, 200, 140)
    love.graphics.print(scaleY, 200, 160)
  end
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

function CheckCollectables() -- function checks if any collectables have been collected
  for i,v in ipairs(collectables) do
    local hitTest = CheckCollision(v.X, v.Y, v.Width, v.Height, pX, pY, pWidth, pHeight)
    if hitTest then
      letter = {}
      letter.Letter = v.Letter
      table.insert(letters, letter)
      table.remove(collectables, i)
      collectableCount = collectableCount - 1
    end
  end
end

function CheckLeftWalls() -- function stops a player from passing through a platform's left wall
  if pState ~= 1 then
    for i,v in ipairs(platforms) do
      local hitTest = CheckCollision(v.X, v.Y + 1, 1, v.Height - 2, pX, pY, pWidth, pHeight)
      if hitTest then
        pX = v.X - pWidth
      end
    end
  end
end

function CheckRightWalls() -- function stops a player from passing through a platform's right wall
  if pState ~= 1 then
    for i,v in ipairs(platforms) do
      local hitTest = CheckCollision(v.X + v.Width - 1, v.Y + 1, 1, v.Height - 2, pX, pY, pWidth, pHeight)
      if hitTest then
        pX = v.X + v.Width
      end
    end
  end
end

function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2) -- function performs a collision check and returns a bool
  return x1 < x2 + w2 and
         x2 < x1 + w1 and
         y1 < y2 + h2 and
         y2 < y1 + h1
end