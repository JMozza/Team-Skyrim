function loadPositions()
  for i = 0, 5 do
    platform = {} -- new platform
    
    if i == 0 then
      platform.Image = rainbowImage
      platform.Width = rainbowImage:getWidth() * scaleX-- constant; platform's width
      platform.Height = rainbowImage:getHeight() * scaleY-- constant; platform's height
      platform.X = 0 -- platform's x co-ordinate -- 0
      platform.Y = love.graphics.getHeight() / 4 -- platform's y co-ordinate -- 120
    elseif i == 1 then
      platform.Image = cloudImage
      platform.Width = cloudImage:getWidth() * scaleX-- constant; platform's width
      platform.Height = cloudImage:getHeight() * scaleY-- constant; platform's height
      platform.X = love.graphics.getWidth() / 1.8 -- platform's x co-ordinate -- 150
      platform.Y = love.graphics.getHeight() / 1.6 -- platform's y co-ordinate -- 300
    elseif i == 2 then
      platform.Image = cloudImage
      platform.Width = cloudImage:getWidth() * scaleX-- constant; platform's width
      platform.Height = cloudImage:getHeight() * scaleY-- constant; platform's height
      platform.X = love.graphics.getWidth() / 1.35 -- platform's x co-ordinate -- 200
      platform.Y = love.graphics.getHeight() / 1.92 -- platform's y co-ordinate -- 250
    elseif i == 3 then
      platform.Image = cloudImage
      platform.Width = cloudImage:getWidth() * scaleX-- constant; platform's width
      platform.Height = cloudImage:getHeight() * scaleY-- constant; platform's height
      platform.X = love.graphics.getWidth() / 1.35 -- platform's x co-ordinate -- 200
      platform.Y = love.graphics.getHeight() / 1.92 -- platform's y co-ordinate -- 250
    elseif i == 4 then
      platform.Image = swingImage
      platform.Width = swingImage:getWidth() * scaleX-- constant; platform's width
      platform.Height = swingImage:getHeight() * scaleY-- constant; platform's height
      platform.X = love.graphics.getWidth() / 1.35 -- platform's x co-ordinate -- 200
      platform.Y = love.graphics.getHeight() / 1.92 -- platform's y co-ordinate -- 250
    elseif i == 5 then
      platform.Image = swingImage
      platform.Width = swingImage:getWidth() * scaleX-- constant; platform's width
      platform.Height = swingImage:getHeight() * scaleY-- constant; platform's height
      platform.X = love.graphics.getWidth() / 1.35 -- platform's x co-ordinate -- 200
      platform.Y = love.graphics.getHeight() / 1.92 -- platform's y co-ordinate -- 250
    end
    
    platform.GroundFound = false -- used for ground check
    table.insert(platforms, platform)
  end  
  
  for i = 1, collectableCount do
    collectable = {} -- new collectable
    collectable.Width = AImage:getWidth() * scaleX -- constant; collectable's width
    collectable.Height = AImage:getHeight() * scaleY -- constant; collectable's height
    widthGen(0, 200) -- set these to the start and end of the platforms
    heightGen(0, 200)
    
    if i == 1 then
      collectable.X = 0
      collectable.Y = 0
    elseif i == 2 then
      collectable.X = 0
      collectable.Y = 0
    else
      collectable.X = random -- this calls a random function with the start and end x and y passed in above
      collectable.Y =  random * 2 -- collectable's y co-ordinate
    end
    
    collectable.Object = i
    collectable.Letter = word.sub(word, i, i) -- letter the collectable represents
    if i == 1 then
      nextLetter = collectable.Letter -- the letter that should be collected next
    end
    collectable.CorrectOrder = true -- false if collectable has been collected in the wrong order
    
    if collectable.Letter == "A" then
      collectable.Image = AImage -- image of the letter
    elseif collectable.Letter == "B" then
      collectable.Image = BImage -- image of the letter
    elseif collectable.Letter == "C" then
      collectable.Image = CImage -- image of the letter
    elseif collectable.Letter == "D" then
      collectable.Image = DImage -- image of the letter
    elseif collectable.Letter == "E" then
      collectable.Image = EImage -- image of the letter
    elseif collectable.Letter == "F" then
      collectable.Image = FImage -- image of the letter
    elseif collectable.Letter == "G" then
      collectable.Image = GImage -- image of the letter
    elseif collectable.Letter == "H" then
      collectable.Image = HImage -- image of the letter
    elseif collectable.Letter == "I" then
      collectable.Image = IImage -- image of the letter
    elseif collectable.Letter == "J" then
      collectable.Image = JImage -- image of the letter
    elseif collectable.Letter == "K" then
      collectable.Image = KImage -- image of the letter
    elseif collectable.Letter == "L" then
      collectable.Image = LImage -- image of the letter
    elseif collectable.Letter == "M" then
      collectable.Image = MImage -- image of the letter
    elseif collectable.Letter == "N" then
      collectable.Image = NImage -- image of the letter
    elseif collectable.Letter == "O" then
      collectable.Image = OImage -- image of the letter
    elseif collectable.Letter == "P" then
      collectable.Image = PImage -- image of the letter
    elseif collectable.Letter == "Q" then
      collectable.Image = QImage -- image of the letter
    elseif collectable.Letter == "R" then
      collectable.Image = RImage -- image of the letter
    elseif collectable.Letter == "S" then
      collectable.Image = SImage -- image of the letter
    elseif collectable.Letter == "T" then
      collectable.Image = TImage -- image of the letter
    elseif collectable.Letter == "U" then
      collectable.Image = UImage -- image of the letter
    elseif collectable.Letter == "V" then
      collectable.Image = VImage -- image of the letter
    elseif collectable.Letter == "W" then
      collectable.Image = WImage -- image of the letter
    elseif collectable.Letter == "X" then
      collectable.Image = XImage -- image of the letter
    elseif collectable.Letter == "Y" then
      collectable.Image = YImage -- image of the letter
    elseif collectable.Letter == "Z" then
      collectable.Image = ZImage -- image of the letter
    end
    
    table.insert(collectables, collectable)
  end
  
  for i=1,5 do
    coin = {} -- new coin
    coin.Width = coinImage:getWidth() * scaleX-- constant; coin's width
    coin.Height = coinImage:getHeight() * scaleY-- constant; coin's height
    coin.X = (i-1) * 50 + 25
    coin.Y = 200
    table.insert(coins, coin)
  end
  
  for i=0,2 do
    star = {} -- new star
    table.insert(stars, star)
  end
end