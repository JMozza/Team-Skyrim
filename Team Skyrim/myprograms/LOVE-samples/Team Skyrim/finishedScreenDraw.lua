function endScreen()
  love.graphics.setFont(font_12)
  love.graphics.print("GAME COMPLETE", 100, 50) -- completion message
  love.graphics.print("STAGE COIN COUNT: "..stageCoinsCollected, 100, 100)
  love.graphics.print("GAME COIN COUNT: "..gameCoinsCollected, 100, 150)
  for i,v in ipairs(stars) do
    love.graphics.draw(starImage, (i - 1) * 60, 200, 0, spriteScalerX, spriteScalerY)
  end
end