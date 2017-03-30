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
  
  local ground = love.graphics.getHeight() * 5 / 6
  
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
    pDirection = 0
    pX = pX - pSpeed
  end
  if pMovingRight then
    pDirection = 1
    pX = pX + pSpeed
  end
  
  if pX < 0 then
    pX = 0
  elseif pX > love.graphics.getWidth() - pWidth then
    pX = love.graphics.getWidth() - pWidth
  end
end

function PlayerJump() -- function makes player rises after a jump input
  if pState == 1 then
    pY = pY - pHeightFromJump * scaleY
    pHeightFromJump = pHeightFromJump - 1
    if pHeightFromJump <= 0 then
      pState = 2
    end
  end
end

function PlayerFall() -- function makes player fall after falling off a ledge or reaching the peak of it's jump and makes the player land
  if pState == 2 then
    pY = pY - pHeightFromJump * scaleY
    pHeightFromJump = pHeightFromJump - 1
    if pY >= pGround - pHeight then
      pHeightFromJump = 0
      pState = 0
      pY = pGround - pHeight
    end
  end
end

function PlayerSprite() -- animate the player using the spritesheets
  if charSel == 1 then 
    if pState == 0 then
      if pMovingLeft then
        if pMovingState ~= 1 then
          pSprite = 0
          pFrames = 0
        end
        pMovingState = 1
        pFrames = pFrames + 1
      
        if pFrames >= 15 then
          pFrames = 0
          pSprite = pSprite + 1
          if pSprite >= 4 then
            pSprite = 0
          end
        end
      
        pImage = pWalkingLeftImage
        pQuad = love.graphics.newQuad(pSprite * pSpriteWidth, 0, pSpriteWidth, pSpriteHeight, pImage:getWidth(), pImage:getHeight())
      elseif pMovingRight then
        if pMovingState ~= 2 then
          pSprite = 0
          pFrames = 0
        end
        pMovingState = 2
        pFrames = pFrames + 1
      
        if pFrames >= 15 then
          pFrames = 0
          pSprite = pSprite + 1
          if pSprite >= 4 then
            pSprite = 0
          end
        end
      
        pImage = pWalkingRightImage
        pQuad = love.graphics.newQuad(pSprite * pSpriteWidth, 0, pSpriteWidth, pSpriteHeight, pImage:getWidth(), pImage:getHeight())
      else
        pMovingState = 0
        pImage = pIdleImage
        pQuad = love.graphics.newQuad(0, 0, pSpriteWidth, pSpriteHeight, pImage:getWidth(), pImage:getHeight())
      end
    else
      if pDirection == 0 then
        if pJumpingState ~= 0 then
          pSprite = 0
          pFrames = 0
        end
        pJumpingState = 0
        pFrames = pFrames + 1
        
        if pFrames >= 5 then
          pFrames = 0
          pSprite = pSprite + 1
          if pSprite >= 8 then
            pSprite = 0
          end
        end
      
        pImage = pJumpingLeftImage
        pQuad = love.graphics.newQuad(pSprite * pSpriteWidth, 0, pSpriteWidth, pSpriteHeight, pImage:getWidth(), pImage:getHeight())
      else
        if pJumpingState ~= 1 then
          pSprite = 0
          pFrames = 0
        end
        pJumpingState = 1
        pFrames = pFrames + 1
        
        if pFrames >= 5 then
          pFrames = 0
          pSprite = pSprite + 1
          if pSprite >= 8 then
            pSprite = 0
          end
        end
        
        pImage = pJumpingRightImage
        pQuad = love.graphics.newQuad(pSprite * pSpriteWidth, 0, pSpriteWidth, pSpriteHeight, pImage:getWidth(), pImage:getHeight())
      end
    end
  end

if charSel == 2 then
  if pState == 0 then
      if pMovingLeft then
        if pMovingState ~= 1 then
          pSprite = 0
          pFrames = 0
        end
        pMovingState = 1
        pFrames = pFrames + 1
      
        if pFrames >= 15 then
          pFrames = 0
          pSprite = pSprite + 1
          if pSprite >= 4 then
            pSprite = 0
          end
        end
      
        pImage = testWalkLeft
        pQuad = love.graphics.newQuad(pSprite * pSpriteWidth, 0, pSpriteWidth, pSpriteHeight, pImage:getWidth(), pImage:getHeight())
      elseif pMovingRight then
        if pMovingState ~= 2 then
          pSprite = 0
          pFrames = 0
        end
        pMovingState = 2
        pFrames = pFrames + 1
      
        if pFrames >= 15 then
          pFrames = 0
          pSprite = pSprite + 1
          if pSprite >= 4 then
            pSprite = 0
          end
        end
      
        pImage = testWalkRight
        pQuad = love.graphics.newQuad(pSprite * pSpriteWidth, 0, pSpriteWidth, pSpriteHeight, pImage:getWidth(), pImage:getHeight())
      else
        pMovingState = 0
        pImage = testIdle
        pQuad = love.graphics.newQuad(0, 0, pSpriteWidth, pSpriteHeight, pImage:getWidth(), pImage:getHeight())
      end
    else
      if pDirection == 0 then
        if pJumpingState ~= 0 then
          pSprite = 0
          pFrames = 0
        end
        pJumpingState = 0
        pFrames = pFrames + 1
        
        if pFrames >= 5 then
          pFrames = 0
          pSprite = pSprite + 1
          if pSprite >= 8 then
            pSprite = 0
          end
        end
      
        pImage = testJumpLeft
        pQuad = love.graphics.newQuad(pSprite * pSpriteWidth, 0, pSpriteWidth, pSpriteHeight, pImage:getWidth(), pImage:getHeight())
      else
        if pJumpingState ~= 1 then
          pSprite = 0
          pFrames = 0
        end
        pJumpingState = 1
        pFrames = pFrames + 1
        
        if pFrames >= 5 then
          pFrames = 0
          pSprite = pSprite + 1
          if pSprite >= 8 then
            pSprite = 0
          end
        end
        
        pImage = testJumpRight
        pQuad = love.graphics.newQuad(pSprite * pSpriteWidth, 0, pSpriteWidth, pSpriteHeight, pImage:getWidth(), pImage:getHeight())
      end
    end
  end
end
function CheckCollectables() -- function checks if any collectables have been collected
  local collected = false
  
  if correctLetterOrder then -- collectables can only be collected if all letters have been collected in the correct order
    for i,v in ipairs(collectables) do
      local hitTest = CheckCollision(v.X, v.Y, v.Width, v.Height, pX, pY, pWidth, pHeight)
      if hitTest then
        if collected == false then
          collected = true
          letter = {}
          letter.Letter = v.Letter
          if letter.Letter == nextLetter then
            local remove = false
            local x = 0
            local y = 0
            local object = 0
            
            for i,v in ipairs(collectables) do
              if v.Letter == nextLetter then
                if remove == false then
                  remove = true
                  x = v.X
                  y = v.Y
                  object = v.Object
                  table.remove(collectables, i)
                end
              end
            end
            
            letter.CorrectOrder = true
            letter.Image = v.Image
            collectableCount = collectableCount - 1
            letterCount = letterCount + 1
            
            if letterCount >= 5 then
              letterLengthOfSide = love.graphics.getWidth() / (letterCount + 1)
            end
            
            if collectables[1] ~= nil then
              v.X = x
              v.Y = y
              v.Object = object
              local first = true
              
              for i,v in ipairs(collectables) do
                if first then
                  nextLetter = v.Letter
                  first = false
                end
              end
            end
          else
            if letterCount >= 4 then
              letterLengthOfSide = love.graphics.getWidth() / (letterCount + 2)
            end
            
            v.CorrectOrder = false
            letter.CorrectOrder = false
            correctLetterOrder = false
            table.remove(stars)
          end
          table.insert(letters, letter)
        end
      end
    end
  end
  
  -- collect coins
  for i,v in ipairs(coins) do
    local hitTest = CheckCollision(v.X, v.Y, v.Width, v.Height, pX, pY, pWidth, pHeight)
    if hitTest then
      stageCoinsCollected = stageCoinsCollected + 1
      gameCoinsCollected = gameCoinsCollected + 1
      table.remove(coins, i)
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