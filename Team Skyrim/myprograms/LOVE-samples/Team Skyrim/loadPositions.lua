function loadPositions()
  for i = 0, 5 do
    platform = {} -- new platform
    
    if i == 0 then
      platform.Image = rainbowImage
      platform.Width = rainbowImage:getWidth() * scaleX * boxScaler -- constant; platform's width
      platform.Height = rainbowImage:getHeight() * scaleY * boxScaler -- constant; platform's height
      platform.X = 0 -- platform's x co-ordinate -- 0
      platform.Y = love.graphics.getHeight() / 6 -- platform's y co-ordinate -- 80
    elseif i == 1 then
      platform.Image = cloudAImage
      platform.Width = cloudAImage:getWidth() * scaleX * boxScaler -- constant; platform's width
      platform.Height = cloudAImage:getHeight() * scaleY * boxScaler -- constant; platform's height
      platform.X = love.graphics.getWidth() / 7.78846153 -- platform's x co-ordinate -- 34.66666666
      platform.Y = love.graphics.getHeight() / 3.6 -- platform's y co-ordinate -- 133.33333333
    elseif i == 2 then
      platform.Image = cloudBImage
      platform.Width = cloudBImage:getWidth() * scaleX * boxScaler -- constant; platform's width
      platform.Height = cloudBImage:getHeight() * scaleY * boxScaler -- constant; platform's height
      platform.X = love.graphics.getWidth() / 2.32758620 -- platform's x co-ordinate -- 116
      platform.Y = love.graphics.getHeight() / 2.65682656 -- platform's y co-ordinate -- 180.66666666
    elseif i == 3 then
      platform.Image = cloudCImage
      platform.Width = cloudCImage:getWidth() * scaleX * boxScaler -- constant; platform's width
      platform.Height = cloudCImage:getHeight() * scaleY * boxScaler -- constant; platform's height
      platform.X = love.graphics.getWidth() / 1.30225080 -- platform's x co-ordinate -- 207.33333333
      platform.Y = love.graphics.getHeight() / 1.96185286 -- platform's y co-ordinate -- 244.66666666
    elseif i == 4 then
      platform.Image = swingImage
      platform.Width = swingImage:getWidth() * scaleX * boxScaler -- constant; platform's width
      platform.Height = swingImage:getHeight() * scaleY * boxScaler -- constant; platform's height
      platform.X = love.graphics.getWidth() / 12.65625 -- platform's x co-ordinate -- 21.33333333
      platform.Y = love.graphics.getHeight() / 1.51898734 -- platform's y co-ordinate -- 316
    elseif i == 5 then
      platform.Image = swingImage
      platform.Width = swingImage:getWidth() * scaleX * boxScaler -- constant; platform's width
      platform.Height = swingImage:getHeight() * scaleY * boxScaler -- constant; platform's height
      platform.X = love.graphics.getWidth() / 1.875 -- platform's x co-ordinate -- 144
      platform.Y = love.graphics.getHeight() / 1.69014084 -- platform's y co-ordinate -- 284
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