function endScreen()
    love.graphics.setFont(font_50)
    love.graphics.print("GAME COMPLETE", 100 * scaleX, 100 * scaleY) -- completion message
    love.graphics.print("STAGE COIN COUNT: "..stageCoinsCollected, 150 * scaleX, 150 * scaleY)
    love.graphics.print("GAME COIN COUNT: "..gameCoinsCollected, 150 * scaleX, 150 * scaleY)
    for i,v in ipairs(stars) do
      love.graphics.draw(starImage, (i - 1) * 50* scaleX, 200* scaleY, 0, spriteScalerX, spriteScalerY)
      love.graphics.print("STAR", (i - 1) * 50* scaleX, 200* scaleY, 0, spriteScalerX, spriteScalerY)
    end
end