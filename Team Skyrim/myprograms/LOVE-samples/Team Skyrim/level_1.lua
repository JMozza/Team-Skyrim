function level1()
  love.graphics.draw(gamebackground, 0, 0, 0, spriteScalerX, spriteScalerY)
  love.graphics.setFont(font_50)
  
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
  love.graphics.print("HINT: "..hint, 0, 450 * scaleY)
  love.graphics.draw(pImage, pQuad, pX, pY, 0, spriteScalerX, spriteScalerY)
end