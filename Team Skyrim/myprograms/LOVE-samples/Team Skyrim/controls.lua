function mousePress(x, y)
  if gamestate == "easy" then  
    local letterTouched = false
    for i,v in ipairs(letters) do
      if v.CorrectOrder == false then
        if y < love.graphics.getHeight() * 5 / 6 + letterLengthOfSide then
          if y >= love.graphics.getHeight() * 5 / 6 then
            if x >= letterCount * letterLengthOfSide then
              if x < (letterCount + 1) * letterLengthOfSide then
                correctLetterOrder = true
                for i,v in ipairs(collectables) do
                  if v.CorrectOrder == false then
                    v.CorrectOrder = true
                  end
                end
                table.remove(letters, i)
                letterTouched = true
                if letterCount >= 4 then
                  letterLengthOfSide = love.graphics.getWidth() / (letterCount + 1)
                end
              end
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
            pHeightFromJump = pJumpHeight
          end
        end
      elseif y < ((love.graphics.getHeight() / 3) * 2 + 80) then
        if pState == 0 then -- fall through a platform
          pHeightFromJump = -1
          pY = pY - pHeightFromJump
          pState = 2
        end
      end
    end
  end
  
  if gamestate == "menu" then
    button_click(x,y)
  end
  
  if gamestate == "scoreboard" then
    sButton_click(x,y)
  end
    
  if gamestate == "character" then
    cButton_click(x,y)
  end
    
  if gamestate == "levelSelect" then
    dButton_click(x,y)
  end
  
  if gamestate == "options" then
    oButton_click(x,y)
  end
end

function mouseReleased()
  pMovingLeft = false
  pMovingRight = false
end

function touchPress(x, y)
  if hastouched == true then
    if gamestate == "easy" then
      local letterTouched = false
      for i,v in ipairs(letters) do
        if v.CorrectOrder == false then
          if y * love.graphics.getHeight() < (love.graphics.getHeight() * 5 / 6 + letterLengthOfSide) * scaleY then
            if y * love.graphics.getHeight() >= (love.graphics.getHeight() * 5 / 6) * scaleY then
              if x * love.graphics.getWidth() >= letterCount * letterLengthOfSide * scaleX then
                if x * love.graphics.getWidth() < (letterCount + 1) * letterLengthOfSide * scaleX then
                  correctLetterOrder = true
                  for i,v in ipairs(collectables) do
                    if v.CorrectOrder == false then
                      v.CorrectOrder = true
                    end
                  end
                  table.remove(letters, i)
                  letterTouched = true
                  if letterCount >= 4 then
                    letterLengthOfSide = love.graphics.getWidth() / (letterCount + 1)
                  end
                end
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
              pHeightFromJump = pJumpHeight
            end
          end
        elseif (y * love.graphics.getHeight()) < ((love.graphics.getHeight() / 3) * 2 + 80) then
          if pState == 0 then -- fall through a platform
            pHeightFromJump = -1
            pY = pY - pHeightFromJump
            pState = 2
          end
        end
      end
      hastouched =true
    end 
     
    if gamestate == "menu" then
      button_click(x * love.graphics.getWidth(),y * love.graphics.getHeight())
      hastouched =true
    end
    
    if gamestate == "scoreboard" then
      sButton_click(x * love.graphics.getWidth(),y * love.graphics.getHeight())
      hastouched =true
    end
      
    if gamestate == "character" then
      cButton_click(x * love.graphics.getWidth(),y * love.graphics.getHeight())
      hastouched =true
    end
      
    if gamestate == "levelSelect" then
      dButton_click(x * love.graphics.getWidth(),y * love.graphics.getHeight())
      hastouched =true
    end
    
    if gamestate == "options" then
      oButton_click(x * love.graphics.getWidth(),y * love.graphics.getHeight())
      hastouched =true
    end
  end
end

function touchReleased()
  pMovingLeft = false
  pMovingRight = false
  hastouched = false
end

--function love.keypressed(key)
--   if key == "space" then
--      startCount = 1
--      objects.block1.body:applyAngularImpulse(-550)
--      objects.block1.body:applyLinearImpulse(-535, -2000)
--      objects.block2.body:applyAngularImpulse(555)
--      objects.block2.body:applyLinearImpulse(520, -2000)
--   end
--end