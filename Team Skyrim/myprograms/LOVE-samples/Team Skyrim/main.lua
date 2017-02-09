function love.load()
  width = 270
  height = 480
  if love.system.getOS() == "Android" then
    local x, y = love.graphics.getDimensions()
    scaleX = (x/width)
    scaleY = (y/height)
  else
    scaleX = 1
    scaleY = 1
  end
 
  --------------------------Physics--------------------------------
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81*64, true)
  
  objects = {}
  
  objects.platform1 = {}
  objects.platform1.body = love.physics.newBody(world, width/2+90, 331) 
  objects.platform1.shape = love.physics.newRectangleShape(50, 1) --make a rectangle with a width of 650 and a height of 50
  objects.platform1.fixture = love.physics.newFixture(objects.platform1.body, objects.platform1.shape); --attach shape to body
  
  objects.platform2 = {}
  objects.platform2.body = love.physics.newBody(world, 25, 430) 
  objects.platform2.shape = love.physics.newRectangleShape(50, 1) --make a rectangle with a width of 650 and a height of 50
  objects.platform2.fixture = love.physics.newFixture(objects.platform2.body, objects.platform2.shape); --attach shape to body
  
  objects.block1 = {}
  objects.block1.body = love.physics.newBody(world, width/2+165, 50, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  objects.block1.shape = love.physics.newRectangleShape(40, 40) --make a rectangle with a width of 650 and a height of 50
  objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 1) -- Attach fixture to body and give it a density of 1.
  objects.block1.fixture:setRestitution(0) --let the ball bounce
  objects.block1.body:setMass(10)
  
  objects.block2 = {}
  objects.block2.body = love.physics.newBody(world, -65, 80, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  objects.block2.shape = love.physics.newRectangleShape(40, 40) --make a rectangle with a width of 650 and a height of 50
  objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 1) -- Attach fixture to body and give it a density of 1.
  objects.block2.fixture:setRestitution(0) --let the ball bounce
  objects.block2.body:setMass(10)
  --------------------------Physics--------------------------------
 -- variables for game
  gameState = 1 -- 0 for main menu, 1 for in a game mode, 2 for level completion, add game state definitions here
  gameMode = 0 -- 0 for english, 1 for maths, 2 for science
  
  -- variables for player
  pState = 0 -- 0 for standing, 1 for jumping, 2 for falling, add player state definitions here
  pSprite = 0 -- sprite from spritesheet player is on on current frame
  pSpeed = 3 * scaleX-- constant; player's speed
  pGround = love.graphics.getHeight() -- height of the ground the player is currently over
  pWidth = 25 * scaleX -- constant; player's width
  pHeight = 25 * scaleY -- constant; player's height
  pX = 0 -- player's x co-ordinate
  pY = pGround - pHeight -- player's y co-ordinate
  pDirection = 1 -- 0 for left, 1 for right
  pJumpHeight = 20 * scaleX -- constant; pixels the player rises in the first frame of a jump
  pGravity = 2 * scaleX-- constant; force due to gravity acting on player
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
      platform.X = love.graphics.getWidth() / 2.7 -- platform's x co-ordinate
      platform.Y = love.graphics.getHeight() / 1.11628 -- platform's y co-ordinate
    elseif i == 1 then
      platform.X = love.graphics.getWidth() / 1.8 -- platform's x co-ordinate
      platform.Y = love.graphics.getHeight() / 1.263158 -- platform's y co-ordinate
    else
      platform.X = love.graphics.getWidth() / 1.35 -- platform's x co-ordinate
      platform.Y = love.graphics.getHeight() / 1.454545 -- platform's y co-ordinate
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
    collectable.Width = collectableImage:getWidth() * scaleX -- constant; collectable's width
    collectable.Height = collectableImage:getHeight() * scaleY -- constant; collectable's height
    if i == 0 then
      collectable.X = 0 -- collectable's x co-ordinate
      collectable.Y = love.graphics.getHeight() / 1.263158 -- collectable's y co-ordinate
      collectable.Letter = "C" -- letter the collectable represents
      collectable.Order = 0 -- first letter in the word
    elseif i == 1 then
      collectable.X = love.graphics.getWidth() / 1.35 -- collectable's x co-ordinate
      collectable.Y = love.graphics.getHeight() / 2.086957 -- collectable's y co-ordinate
      collectable.Letter = "A" -- letter the collectable represents
      collectable.Order = 1 -- second letter in the word
    else
      collectable.X = love.graphics.getWidth() / 1.35 -- collectable's x co-ordinate
      collectable.Y = love.graphics.getHeight() / 1.1162
      collectable.Letter = "T" -- letter the collectable represents
      collectable.Order = 2 -- third letter in the word
    end
    collectable.CorrectOrder = true -- false if collectable has been collected in the wrong order
    table.insert(collectables, collectable)
    collectableCount = collectableCount + 1 -- increment collectable count
  end
  
  -- variables for collected letters
  letters = {} -- collected letters
  letterCount = 0 -- amount of letters
  letterOrder = 0 -- identity of collectable the player should next collect
  correctLetterOrder = true -- true if all letters have currently been collected in the correct order
  incorrectLetterImage = love.graphics.newImage("sprites/Placeholder4.png")
  
  spriteScalerX = 1 * scaleX
  spriteScalerY = 1 * scaleY
  yPressCheck = 50 * scaleY
  
  love.window.setMode(width * scaleX, height * scaleY)
end

function love.keypressed(key)
   if key == "space" then
      startCount = 1
      objects.block1.body:applyAngularImpulse(-550)
      objects.block1.body:applyLinearImpulse(-535, -2000)
      objects.block2.body:applyAngularImpulse(555)
      objects.block2.body:applyLinearImpulse(520, -2000)
   end
end

function love.mousepressed(x, y, button, isTouch)
  local letterTouched = false
  
  for i,v in ipairs(letters) do
    if v.CorrectOrder == false then
      if y <= 50 then
        if x > letterOrder * 50 then
          if x <= letterOrder * 50 + 50 then
            correctLetterOrder = true
            for i,v in ipairs(collectables) do
              if v.CorrectOrder == false then
                v.CorrectOrder = true
              end
            end
            table.remove(letters, i)
            letterTouched = true
          end
        end
      end
    end
  end
  
  if letterTouched == false then
    if y < ((love.graphics.getHeight() / 3) * 2) then
      if x < (love.graphics.getWidth() / 4) then -- move left
        pMovingLeft = true
        pMovingRight = false
      elseif x >= ((love.graphics.getWidth() / 4) * 3) then -- move right
        pMovingLeft = false
        pMovingRight = true
      else -- jump
        pMovingLeft = false
        pMovingRight = false
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
end

function love.mousereleased(x, y, button, isTouch)
  pMovingLeft = false
  pMovingRight = false
end

function love.touchpressed( id, x, y, dx, dy, pressure )
local letterTouched = false
  
  for i,v in ipairs(letters) do
    if v.CorrectOrder == false then
      if y * love.graphics.getHeight() <= yPressCheck then
        if x * love.graphics.getWidth() > (letterOrder * 50 * scaleX) then
          if x * love.graphics.getWidth() <= (letterOrder * 50 + 50) * scaleX then
            correctLetterOrder = true
            for i,v in ipairs(collectables) do
              if v.CorrectOrder == false then
                v.CorrectOrder = true
              end
            end
            table.remove(letters, i)
            letterTouched = true
          end
        end
      end
    end
  end
  
  if letterTouched == false then
    if (y * love.graphics.getHeight()) < ((love.graphics.getHeight() / 3) * 2) then
      if (x * love.graphics.getWidth()) < (love.graphics.getWidth() / 4) then -- move left
        pMovingLeft = true
        pMovingRight = false
      elseif (x * love.graphics.getWidth()) >= ((love.graphics.getWidth() / 4) * 3) then -- move right
        pMovingLeft = false
        pMovingRight = true
      else -- jump
        pMovingLeft = false
        pMovingRight = false
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
  
  -----------------Physics-------------
  if startCount == 1 then
    world:update(dt) --this puts the world into motion
  end
  -----------------Physics-------------
  
  if collectableCount == 0 then -- level complete
    gameState = 2
  end
end

function love.draw()
  love.graphics.setNewFont(50)
  for i,v in ipairs(platforms) do
    love.graphics.draw(platformImage, v.X, v.Y, 0, spriteScalerX, spriteScalerY)
  end
  for i,v in ipairs(collectables) do
    if v.CorrectOrder then
      love.graphics.draw(collectableImage, v.X, v.Y, 0, spriteScalerX, spriteScalerY)
      love.graphics.print(v.Letter, v.X, v.Y, 0, spriteScalerX, spriteScalerY)
    end
  end
  for i,v in ipairs(letters) do
    if v.CorrectOrder then
      love.graphics.draw(collectableImage, (i - 1) * 50, 0, 0, spriteScalerX, spriteScalerY)
    else
      love.graphics.draw(incorrectLetterImage, (i - 1) * 50, 0, 0, spriteScalerX, spriteScalerY)
    end
    love.graphics.setNewFont(50)
    love.graphics.print(v.Letter, (i - 1) * 50, 0)
  end
  love.graphics.draw(pImage, pQuad, pX, pY)
  
  love.graphics.setNewFont(12)
  if gameState == 1 then
    love.graphics.print("controls: top left to move left. top middle", 0, 100)  -- controls
    love.graphics.print("to jump. top right to move right. bottom to", 0, 120)
    love.graphics.print("fall through platform.", 0, 140)
  else
    love.graphics.print("GAME COMPLETE", 100, 100) -- completion message
  end
  -----------------Physics-------------
  --love.graphics.setColor(200, 200, 200)
  --love.graphics.polygon("line", objects.platform1.body:getWorldPoints(objects.platform1.shape:getPoints())) 
  --love.graphics.setColor(200, 200, 200)
  --love.graphics.polygon("line", objects.platform2.body:getWorldPoints(objects.platform2.shape:getPoints())) 
  love.graphics.setColor(200, 200, 200)
  love.graphics.polygon("line", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
  love.graphics.setColor(200, 200, 200)
  love.graphics.polygon("line", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
  -----------------Physics-------------
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
  if correctLetterOrder then -- collectables can only be collected if all letters have been collected in the correct order
    for i,v in ipairs(collectables) do
      local hitTest = CheckCollision(v.X, v.Y, v.Width, v.Height, pX, pY, pWidth, pHeight)
      if hitTest then
        letter = {}
        letter.Letter = v.Letter
        if v.Order == letterOrder then
          table.remove(collectables, i)
          collectableCount = collectableCount - 1
          letterOrder = letterOrder + 1
          letter.CorrectOrder = true
        else
          v.CorrectOrder = false
          letter.CorrectOrder = false
          correctLetterOrder = false
        end
        table.insert(letters, letter)
      end
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