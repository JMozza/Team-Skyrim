local anim8 = require "anim8"
require "menu" --Main menu
require "oMenu" --Options menu
--require "pMenu" --Pause Menu
require "soundBar" --Soundbar in options menu
require "cMenu" --Character Selection Menu
require "sMenu" --Scoreboard Menu

function love.load()
  gamestate = "menu"
  width = 270
  height = 480
  if love.system.getOS() == "Android" then
    local x, y = love.graphics.getDimensions()
    scaleX = (x/width)
    scaleY = (y/height)
  else
    scaleX = 1
    scaleY = 1
  end
 
  --fonts
  font = love.graphics.newFont("fonts/goodd.ttf", 28 * scaleX)
  optionfont = love.graphics.newFont("fonts/goodd.ttf", 12 * scaleX)
  subtitlefont = love.graphics.newFont("fonts/goodd.ttf", 34 * scaleX)
  font_12 = love.graphics.newFont(12* scaleX)
  font_50 = love.graphics.newFont(50)
  
  --images for menu
  titleSpritesheet = love.graphics.newImage("sprites/TitleAnimation.png")
  placeholder = love.graphics.newImage("sprites/placeholderTitle.png")
  checkbox = love.graphics.newImage("sprites/checkbox.png")
  tick = love.graphics.newImage("sprites/tick.png")
  tile = love.graphics.newImage("sprites/tile.png")
  
  --images for gamescreen
  gamebackground = love.graphics.newImage("sprites/Background/BG.png")
  letter = love.graphics.newImage("sprites/testletter.jpg")

  --Animation Variables
  grid = anim8.newGrid(240,56, titleSpritesheet:getWidth(), titleSpritesheet:getHeight())
  animation = anim8.newAnimation(grid("1-13", 1), 0.08)

  --Main Menu Buttons
  --90 200
  button_spawn(90 * scaleX ,150 * scaleY, "Play Game","1")
  button_spawn(55 * scaleX,210 * scaleY, "Character Select","2")
  button_spawn(88 * scaleX,270 * scaleY, "Scoreboard","3")
  button_spawn(102 * scaleX,330 * scaleY, "Options","4")
  button_spawn(115 * scaleX,390 * scaleY, "Quit","5")
    
  --Option Menu Buttons
  oButton_spawn(70 * scaleX,410 * scaleY, "Return To Menu","1")
  oButton_spawn(20 * scaleX,90 * scaleY, "-","2")
  oButton_spawn(250 * scaleX,90 * scaleY, "+","3")
  oButton_spawn(20 * scaleX, 170 * scaleY, "-","4")
  oButton_spawn(250 * scaleX,170 * scaleY, "+","5")
  oButton_spawn(64 * scaleX,250 * scaleY, "Toggle Sounds","6")
  oButton_spawn(72 * scaleX,330 * scaleY, "Visit Our Site","7")

  --Character Selection Buttons
  cButton_spawn(70 * scaleX,420 * scaleY, "Return To Menu","1")
  
  --Scoreboard Menu Buttons
  sButton_spawn(70 * scaleX,420 * scaleY, "Return To Menu","1")
  
  --Pause Menu Buttons
  --pButton_spawn(178,20, "Resume","1")
  --pButton_spawn(160,70, "Return To Menu","2")
  --pButton_spawn(460,70, "Quit","3")

  --volume control variables (unused vriables at the moment, allow volume control in the options menu)
  v_music = 1
  v_effects = 1
 
  --------------------------Physics--------------------------------
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81*64, true)
  
  objects = {}
  
  objects.platform1 = {}
  objects.platform1.body = love.physics.newBody(world, width/2+103, 251) 
  objects.platform1.shape = love.physics.newRectangleShape(50, 1) --make a rectangle with a width of 650 and a height of 50
  objects.platform1.fixture = love.physics.newFixture(objects.platform1.body, objects.platform1.shape); --attach shape to body
  
  objects.platform2 = {}
  objects.platform2.body = love.physics.newBody(world, 80, 140) 
  objects.platform2.shape = love.physics.newRectangleShape(50, 1) --make a rectangle with a width of 650 and a height of 50
  objects.platform2.fixture = love.physics.newFixture(objects.platform2.body, objects.platform2.shape); --attach shape to body
  
  objects.block1 = {}
  objects.block1.body = love.physics.newBody(world, width/2+176, -20, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  objects.block1.shape = love.physics.newRectangleShape(40, 40) --make a rectangle with a width of 650 and a height of 50
  objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 1) -- Attach fixture to body and give it a density of 1.
  objects.block1.fixture:setRestitution(0) --bounce
  objects.block1.body:setMass(10)
  
  objects.block2 = {}
  objects.block2.body = love.physics.newBody(world, -10, -210, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  objects.block2.shape = love.physics.newRectangleShape(40, 40) --make a rectangle with a width of 650 and a height of 50
  objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 1) -- Attach fixture to body and give it a density of 1.
  objects.block2.fixture:setRestitution(0) --bounce
  objects.block2.body:setMass(10)
  --------------------------Physics--------------------------------
  
  -- variables for game
  --gameState = 1 -- 0 for main menu, 1 for in a game mode, 2 for level completion, add game state definitions here
  gameMode = 0 -- 0 for english, 1 for maths, 2 for science
  
  -- variables for player
  pState = 0 -- 0 for standing, 1 for jumping, 2 for falling, add player state definitions here
  pSprite = 0 -- sprite from spritesheet player is on on current frame
  pMovingState = 0 -- 0 for idle, 1 for walking left, 2 for walking right
  pJumpingState = 0 --- 0 for left, 1 for right
  pSpeed = 3 * scaleX-- constant; player's speed
  pGround = love.graphics.getHeight() -- height of the ground the player is currently over
  pWidth = 48 * scaleX -- constant; player's width
  pHeight = 96 * scaleY -- constant; player's height
  pSpriteWidth = 48 -- constant; player's width for sprites from spritesheets
  pSpriteHeight = 96 -- constant; player's height for sprites from spritesheets
  pX = 0 -- player's x co-ordinate
  pY = pGround - pHeight -- player's y co-ordinate
  pDirection = 1 -- 0 for left, 1 for right
  pJumpHeight = 20 * scaleX -- constant; pixels the player rises in the first frame of a jump
  pGravity = 2 * scaleX -- constant; force due to gravity acting on player
  pHeightFromJump = 0 -- pixels player is rising on current frame
  pMovingLeft = false -- true if player is being instructed to move left
  pMovingRight = false -- true if player is being instructed to move right
  pFrames = 0 -- player's frame counter
  pIdleImage = love.graphics.newImage("sprites/Characters/1___Idle.png")
  pWrongImage = love.graphics.newImage("sprites/Characters/2___Wrong.png")
  pCorrectImage = love.graphics.newImage("sprites/Characters/3___Correct.png")
  pWalkingRightImage = love.graphics.newImage("sprites/Characters/4___WalkingRight.png")
  pWalkingLeftImage = love.graphics.newImage("sprites/Characters/5___WalkingLeft.png")
  pJumpingRightImage = love.graphics.newImage("sprites/Characters/6___JumpingRight.png")
  pJumpingLeftImage = love.graphics.newImage("sprites/Characters/7___JumpingLeft.png")
  pImage = pIdleImage -- current spritesheet in use
  pQuad = love.graphics.newQuad(0, 0, pSpriteWidth, pSpriteHeight, pImage:getWidth(), pImage:getHeight())
  
  -- variables for platforms
  platforms = {}
  platformImage = love.graphics.newImage("sprites/Placeholder2.png")
  
  for i=0,2 do
    platform = {} -- new platform
    platform.Width = platformImage:getWidth() * scaleX-- constant; platform's width
    platform.Height = platformImage:getHeight() * scaleY-- constant; platform's height
    if i == 0 then
      platform.X = love.graphics.getWidth() / 2.7 -- platform's x co-ordinate
      platform.Y = love.graphics.getHeight() / 1.11628 -- platform's y co-ordinate
    elseif i == 1 then
      platform.X = love.graphics.getWidth() / 1.8 -- platform's x co-ordinate
      platform.Y = love.graphics.getHeight() / 1.263158 -- platform's y co-ordinate
    else
      platform.X = love.graphics.getWidth() / 1.35 -- platform's x co-ordinate
      platform.Y = love.graphics.getHeight() / 1.454545 -- platform's y co-ordinate
    end
    platform.GroundFound = false -- used for ground check
    table.insert(platforms, platform)
  end
  
  --variables for collectables
  collectables = {} -- collectables on the screen
  collectableCount = 0 -- amount of collectables
  AImage = love.graphics.newImage("sprites/Props/Letters/A.png")
  BImage = love.graphics.newImage("sprites/Props/Letters/B.png")
  CImage = love.graphics.newImage("sprites/Props/Letters/C.png")
  DImage = love.graphics.newImage("sprites/Props/Letters/D.png")
  EImage = love.graphics.newImage("sprites/Props/Letters/E.png")
  FImage = love.graphics.newImage("sprites/Props/Letters/F.png")
  GImage = love.graphics.newImage("sprites/Props/Letters/G.png")
  HImage = love.graphics.newImage("sprites/Props/Letters/H.png")
  IImage = love.graphics.newImage("sprites/Props/Letters/I.png")
  JImage = love.graphics.newImage("sprites/Props/Letters/J.png")
  KImage = love.graphics.newImage("sprites/Props/Letters/K.png")
  LImage = love.graphics.newImage("sprites/Props/Letters/L.png")
  MImage = love.graphics.newImage("sprites/Props/Letters/M.png")
  NImage = love.graphics.newImage("sprites/Props/Letters/N.png")
  OImage = love.graphics.newImage("sprites/Props/Letters/O.png")
  PImage = love.graphics.newImage("sprites/Props/Letters/P.png")
  QImage = love.graphics.newImage("sprites/Props/Letters/Q.png")
  RImage = love.graphics.newImage("sprites/Props/Letters/R.png")
  SImage = love.graphics.newImage("sprites/Props/Letters/S.png")
  TImage = love.graphics.newImage("sprites/Props/Letters/T.png")
  UImage = love.graphics.newImage("sprites/Props/Letters/U.png")
  VImage = love.graphics.newImage("sprites/Props/Letters/V.png")
  WImage = love.graphics.newImage("sprites/Props/Letters/W.png")
  XImage = love.graphics.newImage("sprites/Props/Letters/X.png")
  YImage = love.graphics.newImage("sprites/Props/Letters/Y.png")
  ZImage = love.graphics.newImage("sprites/Props/Letters/Z.png")
  
  -- different letter lengths
  word = "DANIEL"
  wordLength = #word
  
  for i=0,wordLength-1 do
    collectable = {} -- new collectable
    collectable.Width = AImage:getWidth() * scaleX -- constant; collectable's width
    collectable.Height = AImage:getHeight() * scaleY -- constant; collectable's height
    widthGen(0, 200) -- set these to the start and end of the platforms
    heightGen(0, 3)
    if i == 0 then
      collectable.X = 0 -- collectable's x co-ordinate
      collectable.Y = love.graphics.getHeight() / 2 -- collectable's y co-ordinate
      collectable.Letter = "B" -- letter the collectable represents
      collectable.Image = BImage -- image of the letter
      nextLetter = collectable.Letter -- the letter that should be collected next
    end
    collectable.X = random -- this calls a random function with the start and end x and y passed in above
    collectable.Y =  0--love.graphics.getHeight() -- collectable's y co-ordinate
    collectable.Letter = word.sub(word,i+1,i+1) -- letter the collectable represents
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
    collectableCount = collectableCount + 1 -- increment collectable count
  end
  
  -- variables for collected letters
  letters = {} -- collected letters
  letterCount = 0 -- amount of letters
  correctLetterOrder = true -- true if all letters have currently been collected in the correct order
  incorrectLetterImage = love.graphics.newImage("sprites/Placeholder4.png")
  
  -- variables for stars
  stars = {} -- stars earned. every round starts with 3 stars. stars get taken away for errors and are presented at the end of a level
  for i=0,2 do
    star = {} -- new star
    table.insert(stars, star)
  end
  starImage = love.graphics.newImage("sprites/Placeholder5.png")
  
  spriteScalerX = 1 * scaleX
  spriteScalerY = 1 * scaleY
  yPressCheck = 50 * scaleY
  
  hastouched = false
  
  love.window.setMode(width * scaleX, height * scaleY)
end

function love.keypressed(key)
   if key == "space" then
      startCount = 1
      objects.block1.body:applyAngularImpulse(-550)
      objects.block1.body:applyLinearImpulse(-535, -2000)
      objects.block2.body:applyAngularImpulse(555)
      objects.block2.body:applyLinearImpulse(520, -2000)
   end
end

function love.mousepressed(x, y, button, isTouch)
  if gamestate == "easy" then  
    local letterTouched = false
    for i,v in ipairs(letters) do
      if v.CorrectOrder == false then
        if y <= 50 then
          if x > letterCount * 50 then
            if x <= letterCount * 50 + 50 then
              correctLetterOrder = true
              for i,v in ipairs(collectables) do
                if v.CorrectOrder == false then
                  v.CorrectOrder = true
                end
              end
              table.remove(letters, i)
              letterTouched = true
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
            pHeightFromJump = 20
          end
        end
      else
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

function love.mousereleased(x, y, button, isTouch)
  pMovingLeft = false
  pMovingRight = false
end

function love.touchpressed( id, x, y, dx, dy, pressure )
  if hastouched == true then
    if gamestate == "easy" then
      local letterTouched = false
      startCount = 1
      objects.block1.body:applyAngularImpulse(-550)
      objects.block1.body:applyLinearImpulse(-535, -2000)
      objects.block2.body:applyAngularImpulse(555)
      objects.block2.body:applyLinearImpulse(520, -2000)
      for i,v in ipairs(letters) do
        if v.CorrectOrder == false then
          if y * love.graphics.getHeight() <= yPressCheck then
            if x * love.graphics.getWidth() > (letterOrder * (50 * scaleX) * scaleX) then
              if x * love.graphics.getWidth() <= ((letterOrder * 50 + 50) * scaleX) * scaleX then
                correctLetterOrder = true
                for i,v in ipairs(collectables) do
                  if v.CorrectOrder == false then
                    v.CorrectOrder = true
                  end
                end
                table.remove(letters, i)
                letterTouched = true
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
              pHeightFromJump = 20
            end
          end
        else
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

function love.touchreleased( id, x, y, dx, dy, pressure )
  pMovingLeft = false
  pMovingRight = false
  hastouched = false
end

function love.update(dt)
  mousex = love.mouse.getX()
  mousey = love.mouse.getY()
  
  if gamestate == "menu" then
    button_check()
    animation:update(dt)
  end
  
  if gamestate == "character" then
    cButton_check()
    animation:update(dt)
  end
  
  if gamestate == "scoreboard" then
    sButton_check()
    animation:update(dt)
  end
  
  if gamestate == "options" then
    oButton_check()
    animation:update(dt)
  end
    
  if gamestate == "easy" and love.keyboard.isDown("return") then
    gamestate = "menu"
  end
  
  if gamestate == "easy" then
    CheckGround()
    PlayerMove()
    PlayerJump()
    PlayerFall()
    PlayerSprite()
    CheckCollectables()
    CheckLeftWalls()
    CheckRightWalls()

  end
  
  -----------------Physics-------------
  if startCount == 1 then
    world:update(dt)
     --this puts the world into motion
  end
  -----------------Physics-------------
  
  if collectableCount == 0 then -- level complete
    gamestate = "easyComplete"
  end
end

function love.draw()
  if gamestate == "easy" then
    love.graphics.draw(gamebackground, 0, 0, 0, spriteScalerX, spriteScalerY)
    love.graphics.setFont(font_50)
    for i,v in ipairs(platforms) do
      love.graphics.draw(platformImage, v.X, v.Y, 0, spriteScalerX, spriteScalerY)
    end
    for i,v in ipairs(collectables) do
      if v.CorrectOrder then
        love.graphics.draw(v.Image, v.X, v.Y, 0, spriteScalerX, spriteScalerY)
      end
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
 
    love.graphics.setNewFont(12)
    love.graphics.print("controls: top left to move left. top middle", 0, 100)  -- controls
    love.graphics.print("to jump. top right to move right. bottom to", 0, 120)
    love.graphics.print("fall through platform.", 0, 140)
    
    
    love.graphics.draw(BImage, objects.block1.body:getX() - 25, objects.block1.body:getY() - 25)
    
    love.graphics.draw(BImage, objects.block2.body:getX() - 25, objects.block2.body:getY() - 25)
  else
    love.graphics.setFont(font_50)
    love.graphics.print("GAME COMPLETE", 100 * scaleX, 100 * scaleY) -- completion message
    for i,v in ipairs(stars) do
      love.graphics.draw(starImage, (i - 1) * 50* scaleX, 200* scaleY, 0, spriteScalerX, spriteScalerY)
      love.graphics.print("STAR", (i - 1) * 50* scaleX, 200* scaleY, 0, spriteScalerX, spriteScalerY)
    end
  end
        
  if gamestate == "menu" then
    love.graphics.draw(placeholder, 0, 0, 0, spriteScalerX, spriteScalerY)
    animation:draw(titleSpritesheet, 15, 15, 0, spriteScalerX, spriteScalerY)
    button_draw()
  end
  
  if gamestate == "scoreboard" then
    love.graphics.draw(placeholder, 0, 0, 0, spriteScalerX, spriteScalerY)
    sButton_draw()
    animation:draw(titleSpritesheet, 15, 15, 0, spriteScalerX, spriteScalerY)
    love.graphics.setColor(0,255,12)
    love.graphics.setFont(subtitlefont)
    love.graphics.print("Your High Scores", 50 * scaleX, 90 * scaleY)
    love.graphics.setColor(255,255,255)
  end
  
  if gamestate == "character" then
    love.graphics.draw(placeholder, 0, 0, 0, spriteScalerX, spriteScalerY)
    cButton_draw()
    love.graphics.setColor(255,0,255)
    love.graphics.setFont(subtitlefont)
    love.graphics.print("Select your character", 20 *scaleX, 90 * scaleY)
    love.graphics.setColor(255,255,255)
    animation:draw(titleSpritesheet, 15, 15, 0, spriteScalerX, spriteScalerY)
    love.graphics.setColor(255,255,255)
  end
    
  if gamestate == "options" then
    love.graphics.setFont(optionfont)
    love.graphics.draw(placeholder, 0, 0, 0, spriteScalerX, spriteScalerY)
    animation:draw(titleSpritesheet, 15, 15, 0, spriteScalerX, spriteScalerY)
    oButton_draw()
    love.graphics.draw(checkbox, 185, 251)    
    sound_bars()
  end
  -----------------Physics-------------
  --love.graphics.setColor(200, 200, 200)
  --love.graphics.polygon("line", objects.platform1.body:getWorldPoints(objects.platform1.shape:getPoints())) 
  --love.graphics.setColor(200, 200, 200)
  --love.graphics.polygon("line", objects.platform2.body:getWorldPoints(objects.platform2.shape:getPoints())) 
  --love.graphics.setColor(255, 0, 0)
  --love.graphics.draw(letter, objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
  --love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
  --love.graphics.setColor(0, 0, 255)
  --love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
  --love.graphics.setColor(200, 200, 200)
  -----------------Physics-------------
end

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
  
  local ground = love.graphics.getHeight()
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

function CheckCollectables() -- function checks if any collectables have been collected
  if correctLetterOrder then -- collectables can only be collected if all letters have been collected in the correct order
    for i,v in ipairs(collectables) do
      local hitTest = CheckCollision(v.X, v.Y, v.Width, v.Height, pX, pY, pWidth, pHeight)
      if hitTest then
        letter = {}
        letter.Letter = v.Letter
        if v.Letter == nextLetter then
          table.remove(collectables, i)
          letter.CorrectOrder = true
          letter.Image = v.Image
          letterCount = letterCount + 1
          collectableCount = collectableCount - 1
          
          if next(collectables) ~= nil then
            local first = true
            for i,v in ipairs(collectables) do
              if first then
                nextLetter = v.Letter
                first = false
              end
            end
          end
          
        else
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

function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2) -- function performs a collision check and returns a bool
  return x1 < x2 + w2 and
         x2 < x1 + w1 and
         y1 < y2 + h2 and
         y2 < y1 + h1
end

function heightGen(bottomLevel, toplevel) -- this function is used for the positions of the collectables upon level creation
   random2 = math.random(bottomLevel, toplevel)
end

function widthGen(startWidth, endWidth) -- this function is used for the positions of the collectables upon level creation
   random = math.random(startWidth, endWidth)
end