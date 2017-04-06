function completeGame()
  love.graphics.setFont(font_12)
  love.graphics.print("GAME COMPLETE", 100, 50) -- completion message
  love.graphics.print("GAME COIN COUNT: "..gameCoinsCollected, 100, 150)
  love.graphics.print("TOUCH ANYWHERE TO CLOSE", 0, 300)
end