function level1()
  love.graphics.draw(gamebackground, 0, 0, 0, spriteScalerX, spriteScalerY)
  love.graphics.setFont(font_50)
  
  for i,v in ipairs(platforms) do
    love.graphics.draw(platformImage, v.X, v.Y, 0, spriteScalerX, spriteScalerY)
  end
  
  for i,v in ipairs(collectables) do
    if v.collectables then
      love.graphics.draw(v.Image, v.X, v.Y, 0, spriteScalerX, spriteScalerY)
    end
  end
  
  for i,v in ipairs(coins) do
    love.graphics.draw(coinImage, v.X, v.Y, 0, spriteScalerX, spriteScalerY)
  end
  
  for i,v in ipairs(letters) do
    if v.CorrectOrder then
      love.graphics.draw(v.Image, (i - 1) * 50, 0, 0, spriteScalerX, spriteScalerY)
    else
      love.graphics.draw(incorrectLetterImage, (i - 1) * 50, 0, 0, spriteScalerX, spriteScalerY)
      love.graphics.print(v.Letter, (i - 1) * 50, 0)
    end
  end
  
  love.graphics.draw(pImage, pQuad, pX, pY, 0, spriteScalerX, spriteScalerY)   
  love.graphics.draw(BImage, objects.block1.body:getX() - 25, objects.block1.body:getY() - 25)
  
  love.graphics.draw(BImage, objects.block2.body:getX() - 25, objects.block2.body:getY() - 25) 
  love.graphics.setFont(font_12)  
  love.graphics.print("controls: top left to move left. top middle", 0, 100 * scaleY)  -- controls
  love.graphics.print("to jump. top right to move right. bottom to", 0, 120 * scaleY)
  love.graphics.print("fall through platform.", 0, 140 * scaleY)
  love.graphics.draw(pImage, pQuad, pX, pY, 0, spriteScalerX, spriteScalerY)
end