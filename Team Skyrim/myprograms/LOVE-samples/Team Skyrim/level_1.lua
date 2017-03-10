function level1()
  --for i,v in ipairs(platforms) do
    --love.graphics.draw(v.Image, v.X, v.Y, 0, spriteScalerX, spriteScalerY)
  --end
  
  love.graphics.draw(gamebackground, 0, 0, 0, spriteScalerX, spriteScalerY)
  love.graphics.setFont(font_50)
  
  for i,v in ipairs(platforms) do
    love.graphics.draw(v.Image, v.X, v.Y, 0, spriteScalerX * boxScaler, spriteScalerY * boxScaler)
  end
  
  for i,v in ipairs(collectables) do
    if v.CorrectOrder then
      love.graphics.draw(v.Image, v.X, v.Y, 0, spriteScalerX, spriteScalerY)
    end
  end
  
  for i,v in ipairs(coins) do
    love.graphics.draw(coinImage, v.X, v.Y, 0, spriteScalerX, spriteScalerY)
  end
  
  for i,v in ipairs(letters) do
    if v.CorrectOrder then
      love.graphics.draw(v.Image, (i - 1) * 50, 400, 0, spriteScalerX, spriteScalerY)
    else
      love.graphics.draw(incorrectLetterImage, (i - 1) * 50, 400, 0, spriteScalerX, spriteScalerY)
      love.graphics.print(v.Letter, (i - 1) * 50, 400)
    end
  end
  
  love.graphics.setFont(font_12)  
  love.graphics.print("controls: top left to move left. top middle", 0, 100 * scaleY)  -- controls
  love.graphics.print("to jump. top right to move right. bottom to", 0, 120 * scaleY)
  love.graphics.print("fall through platform.", 0, 140 * scaleY)
  love.graphics.print("HINT: "..hint, 0, 450 * scaleY)
  love.graphics.draw(pImage, pQuad, pX, pY, 0, spriteScalerX, spriteScalerY)
end