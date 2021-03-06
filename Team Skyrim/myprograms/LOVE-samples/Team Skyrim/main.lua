local anim8 = require "anim8"
require "menu" --Main menu
require "oMenu" --Options menu
--require "pMenu" --Pause Menu
require "soundBar" --Soundbar in options menu
require "cMenu" --Character Selection Menu
require "sMenu" --Scoreboard Menu
require "playerMovement"
require "newPositions"
require "controls"
require "level_1"
require "loadPositions"
require "finishedScreenDraw"
require "randomPositions"
require "completedScreenDraw"

function love.load()  
  
  math.randomseed(os.time()) -- needed for random generation
  gamestate = "menu"
  --setting OS
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
  
  --variables for collectables
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
  
  --images for gamescreen
  gamebackground = love.graphics.newImage("sprites/Background/BG.png")
  letter = love.graphics.newImage("sprites/testletter.jpg")
  
  --images for menu
  titleSpritesheet = love.graphics.newImage("sprites/TitleAnimation.png")
  placeholder = love.graphics.newImage("sprites/placeholderTitle.png")
  checkbox = love.graphics.newImage("sprites/checkbox.png")
  tick = love.graphics.newImage("sprites/tick.png")
  tile = love.graphics.newImage("sprites/tile.png")
  
  --charcter animation
  pIdleImage = love.graphics.newImage("sprites/Characters/1___Idle.png")
  pWrongImage = love.graphics.newImage("sprites/Characters/2___Wrong.png")
  pCorrectImage = love.graphics.newImage("sprites/Characters/3___Correct.png")
  pWalkingRightImage = love.graphics.newImage("sprites/Characters/4___WalkingRight.png")
  pWalkingLeftImage = love.graphics.newImage("sprites/Characters/5___WalkingLeft.png")
  pJumpingRightImage = love.graphics.newImage("sprites/Characters/6___JumpingRight.png")
  pJumpingLeftImage = love.graphics.newImage("sprites/Characters/7___JumpingLeft.png")
  
  testIdle = love.graphics.newImage("sprites/Characters/testIdle.png")
  testWalkLeft = love.graphics.newImage("sprites/Characters/testWalkLeft.png")
  testWalkRight = love.graphics.newImage("sprites/Characters/testWalkRight.png")
  testJumpLeft = love.graphics.newImage("sprites/Characters/testJumpLeft.png")
  testJumpRight = love.graphics.newImage("sprites/Characters/testJumpRight.png")
  
  --fonts
  font = love.graphics.newFont("fonts/goodd.ttf", 28 * scaleX)
  optionfont = love.graphics.newFont("fonts/goodd.ttf", 12 * scaleX)
  subtitlefont = love.graphics.newFont("fonts/goodd.ttf", 34 * scaleX)
  font_12 = love.graphics.newFont(12 * scaleX)
  font_50 = love.graphics.newFont(50 * scaleX)

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

  --Variable for Character selection
  charSel = 1

  --Character Selection Buttons
  cButton_spawn(70 * scaleX,430 * scaleY, "Return To Menu","1")
  cButton_spawn(40 * scaleX,250 * scaleY, "Select","2")
  cButton_spawn(160 * scaleX,250 * scaleY, "Select","3")
  cButton_spawn(40 * scaleX,395 * scaleY, "Select","4")
  cButton_spawn(160 * scaleX,395 * scaleY, "Select","5")
  
  --Scoreboard Menu Buttons
  sButton_spawn(70 * scaleX,420 * scaleY, "Return To Menu","1")
  
  --Pause Menu Buttons
  --pButton_spawn(178,20, "Resume","1")
  --pButton_spawn(160,70, "Return To Menu","2")
  --pButton_spawn(460,70, "Quit","3")

  --volume control variables (unused variables at the moment, allow volume control in the options menu)
  v_music = 1
  v_effects = 1
  
  -- variables for game
  --gameState = 1 -- 0 for main menu, 1 for in a game mode, 2 for level completion, add game state definitions here
  gameMode = 0 -- 0 for english, 1 for maths, 2 for science
  level = 0 -- level the player is on
  
  pSpeed = 3 * scaleX-- constant; player's speed
  pWidth = 48 * scaleX -- constant; player's width
  pHeight = 96 * scaleY -- constant; player's height
  pSpriteWidth = 48 -- constant; player's width for sprites from spritesheets
  pSpriteHeight = 96 -- constant; player's height for sprites from spritesheets
  pJumpHeight = 15 -- constant; pixels the player rises in the first frame of a jump
  pGravity = 2 * scaleX -- constant; force due to gravity acting on player
  
  rainbowImage = love.graphics.newImage("sprites/New backgrounds/boxRAINBOW.png")
  cloudAImage = love.graphics.newImage("sprites/New backgrounds/boxCLOUDa.png")
  cloudBImage = love.graphics.newImage("sprites/New backgrounds/boxCLOUDb.png")
  cloudCImage = love.graphics.newImage("sprites/New backgrounds/boxCLOUDc.png")
  swingImage = love.graphics.newImage("sprites/New backgrounds/boxSWING.png")
  boxScaler = 2 / 3
  
  incorrectLetterImage = love.graphics.newImage("sprites/Placeholder4.png")
  
  starImage = love.graphics.newImage("sprites/Placeholder5.png")
  
  gameCoinsCollected = 0 -- amount of coins the player has collected throughout the game
  coinImage = love.graphics.newImage("sprites/checkbox.png")
  
  spriteScalerX = 1 * scaleX
  spriteScalerY = 1 * scaleY
  
  Reset()
  
  hastouched = false
  
  love.window.setMode(width * scaleX, height * scaleY)
end

function Reset()
  level = level + 1
  
  collectables = {} -- collectables on the screen
  
  --------------------------Physics--------------------------------
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81*64, true)
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)
  persisting = 0
  
  objects = {}
  
  objects.platform1 = {}
  objects.platform1.body = love.physics.newBody(world, width/2+103, 251) 
  objects.platform1.shape = love.physics.newRectangleShape(50, 1) 
  objects.platform1.fixture = love.physics.newFixture(objects.platform1.body, objects.platform1.shape);
  
  objects.platform2 = {}
  objects.platform2.body = love.physics.newBody(world, 80, 140) 
  objects.platform2.shape = love.physics.newRectangleShape(50, 1) 
  objects.platform2.fixture = love.physics.newFixture(objects.platform2.body, objects.platform2.shape);
  
  objects.block1 = {}
  objects.block1.body = love.physics.newBody(world, width/2+176, -20, "dynamic") 
  objects.block1.shape = love.physics.newRectangleShape(40, 40) 
  objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 1) 
  objects.block1.fixture:setRestitution(0) --bounce
  objects.block1.body:setMass(10)
  
  objects.block2 = {}
  objects.block2.body = love.physics.newBody(world, -10, -210, "dynamic")
  objects.block2.body = love.physics.newBody(world, -10, -210, "dynamic")
  objects.block2.shape = love.physics.newRectangleShape(40, 40) 
  objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 1)
  objects.block2.fixture:setRestitution(0) --bounce
  objects.block2.body:setMass(10)
  
  --objects.character = {}
  --objects.character.body = love.physics.newBody(world, pX, pY, "dynamic")
  --objects.character.shape = love.physics.newRectangleShape(40, 40) 
  --objects.character.fixture = love.physics.newFixture(objects.character.body, objects.character.shape, 1) 
  --objects.character.f:setUserData("Character") for data output
  --------------------------Physics--------------------------------
  
  -- variables for player
  pState = 0 -- 0 for standing, 1 for jumping, 2 for falling, add player state definitions here
  pSprite = 0 -- sprite from spritesheet player is on on current frame
  pMovingState = 0 -- 0 for idle, 1 for walking left, 2 for walking right
  pJumpingState = 0 --- 0 for left, 1 for right
  pGround = love.graphics.getHeight() * 5 / 6 -- height of the ground the player is currently over
  pX = 0 -- player's x co-ordinate
  pY = pGround - pHeight -- player's y co-ordinate
  pDirection = 1 -- 0 for left, 1 for right
  pHeightFromJump = 0 -- pixels player is rising on current frame
  pMovingLeft = false -- true if player is being instructed to move left
  pMovingRight = false -- true if player is being instructed to move right
  pFrames = 0 -- player's frame counter
  pImage = pIdleImage -- current spritesheet in use
  pQuad = love.graphics.newQuad(0, 0, pSpriteWidth, pSpriteHeight, pImage:getWidth(), pImage:getHeight())
  
  -- variables for platforms
  platforms = {}
  
  -- different letter lengths
  if level == 1 then
    word = "FAST"
    hint = "Very quick"
  elseif level == 2 then
    word = "GAMES"
    hint = "Fun to play"
  else
    word = "MOON"
    hint = "In the sky"
  end
  
  collectableCount = #word
  
  -- variables for collected letters
  letters = {} -- collected letters
  letterCount = 0 -- amount of letters
  letterLengthOfSide = (love.graphics.getWidth() / 5) * scaleX -- size of letter
  correctLetterOrder = true -- true if all letters have currently been collected in the correct order
  
  -- variables for stars
  stars = {} -- stars earned. every round starts with 3 stars. stars get taken away for errors and are presented at the end of a level
  
  -- variables for coins
  coins = {} -- coins collected since the game started
  stageCoinsCollected = 0 -- amount of coins the player has collected in the stage
  
  loadPositions()
end

function charReset()
  gamestate = "menu"
  
  level = level + 1
  
  collectables = {} -- collectables on the screen
  
  --------------------------Physics--------------------------------
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81*64, true)
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)
  persisting = 0
  
  objects = {}
  
  objects.platform1 = {}
  objects.platform1.body = love.physics.newBody(world, width/2+103, 251) 
  objects.platform1.shape = love.physics.newRectangleShape(50, 1) 
  objects.platform1.fixture = love.physics.newFixture(objects.platform1.body, objects.platform1.shape);
  
  objects.platform2 = {}
  objects.platform2.body = love.physics.newBody(world, 80, 140) 
  objects.platform2.shape = love.physics.newRectangleShape(50, 1) 
  objects.platform2.fixture = love.physics.newFixture(objects.platform2.body, objects.platform2.shape);
  
  objects.block1 = {}
  objects.block1.body = love.physics.newBody(world, width/2+176, -20, "dynamic") 
  objects.block1.shape = love.physics.newRectangleShape(40, 40) 
  objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 1) 
  objects.block1.fixture:setRestitution(0) --bounce
  objects.block1.body:setMass(10)
  
  objects.block2 = {}
  objects.block2.body = love.physics.newBody(world, -10, -210, "dynamic")
  objects.block2.body = love.physics.newBody(world, -10, -210, "dynamic")
  objects.block2.shape = love.physics.newRectangleShape(40, 40) 
  objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 1)
  objects.block2.fixture:setRestitution(0) --bounce
  objects.block2.body:setMass(10)
  
  --objects.character = {}
  --objects.character.body = love.physics.newBody(world, pX, pY, "dynamic")
  --objects.character.shape = love.physics.newRectangleShape(40, 40) 
  --objects.character.fixture = love.physics.newFixture(objects.character.body, objects.character.shape, 1) 
  --objects.character.f:setUserData("Character") for data output
  --------------------------Physics--------------------------------
  
  -- variables for player
  pState = 0 -- 0 for standing, 1 for jumping, 2 for falling, add player state definitions here
  pSprite = 0 -- sprite from spritesheet player is on on current frame
  pMovingState = 0 -- 0 for idle, 1 for walking left, 2 for walking right
  pJumpingState = 0 --- 0 for left, 1 for right
  pGround = love.graphics.getHeight() * 5 / 6 -- height of the ground the player is currently over
  pX = 0 -- player's x co-ordinate
  pY = pGround - pHeight -- player's y co-ordinate
  pDirection = 1 -- 0 for left, 1 for right
  pHeightFromJump = 0 -- pixels player is rising on current frame
  pMovingLeft = false -- true if player is being instructed to move left
  pMovingRight = false -- true if player is being instructed to move right
  pFrames = 0 -- player's frame counter
  pImage = pIdleImage -- current spritesheet in use
  pQuad = love.graphics.newQuad(0, 0, pSpriteWidth, pSpriteHeight, pImage:getWidth(), pImage:getHeight())
  
  -- variables for platforms
  platforms = {}
  
  -- different letter lengths
  if level == 1 then
    word = "GAMES"
    hint = "Fun to play"
  elseif level == 2 then
    word = "DICKS"
    hint = "Kinda phallic"
  else
    word = "ECKSDEE"
    hint = "xD"
  end
  
  collectableCount = #word
  
  -- variables for collected letters
  letters = {} -- collected letters
  letterCount = 0 -- amount of letters
  letterLengthOfSide = (love.graphics.getWidth() / 5) * scaleX -- size of letter
  correctLetterOrder = true -- true if all letters have currently been collected in the correct order
  
  -- variables for stars
  stars = {} -- stars earned. every round starts with 3 stars. stars get taken away for errors and are presented at the end of a level
  
  -- variables for coins
  coins = {} -- coins collected since the game started
  stageCoinsCollected = 0 -- amount of coins the player has collected in the stage
  
  loadPositions()
end

function Delete()
  for i,v in ipairs(collectables) do
    collectables[i] = nil
  end
  for i,v in ipairs(objects.platform1) do
    objects.platform1[i] = nil
  end
  for i,v in ipairs(objects.platform2) do
    objects.platform2[i] = nil
  end
  for i,v in ipairs(objects.block1) do
    objects.block1[i] = nil
  end
  for i,v in ipairs(objects.block2) do
    objects.block2[i] = nil
  end
  for i,v in ipairs(objects) do
    objects[i] = nil
  end
  for i,v in ipairs(platforms) do
    platforms[i] = nil
  end
  for i,v in ipairs(letters) do
    letters[i] = nil
  end
  for i,v in ipairs(stars) do
    stars[i] = nil
  end
  for i,v in ipairs(coins) do
    coins[i] = nil
  end
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
    charReset()
  end
  
  if gamestate == "easy" then
    CheckGround()
    PlayerMove()
    PlayerJump()
    PlayerFall()
    PlayerSprite()
    
    for i,v in ipairs(collectables) do
      if v.Object == 1 then
        v.X = (objects.block1.body:getX() - 25) * scaleX
        v.Y = (objects.block1.body:getY() - 25) * scaleY
      elseif v.Object == 2 then
        v.X = (objects.block2.body:getX() - 25) * scaleX
        v.Y = (objects.block2.body:getY() - 25) * scaleY
      end
    end
    
    CheckCollectables()
  end
  
  -----------------Physics-------------
  if startCount == 1 then
    world:update(dt)
    --this puts the world into motion
  end
  -----------------Physics-------------
  
  if collectableCount == 0 then -- level complete
    Delete()
    if level == 3 then
      gamestate = "complete"
    else
      gamestate = "easyComplete"
    end
  end
end

function love.draw()
  if gamestate == "easy" then    
    level1()
  end
  
  if gamestate == "easyComplete" then
    endScreen()
  end
  
  if gamestate == "complete" then
    completeGame()
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
    love.graphics.print("Select your character", 20 * scaleX, 90 * scaleY)
    love.graphics.setColor(255,255,255)
    charSelection()
    love.graphics.draw(pIdleImage, 45 * scaleX, 144 * scaleY, 0, spriteScalerX, spriteScalerY)
    love.graphics.draw(testIdle, 166 * scaleX, 144 * scaleY, 0, spriteScalerX, spriteScalerY)
    animation:draw(titleSpritesheet, 15, 15, 0, spriteScalerX, spriteScalerY)
    love.graphics.setColor(255, 255, 255)
  end
    
  if gamestate == "options" then
    love.graphics.setFont(optionfont)
    love.graphics.draw(placeholder, 0, 0, 0, spriteScalerX, spriteScalerY)
    animation:draw(titleSpritesheet, 15, 15, 0, spriteScalerX, spriteScalerY)
    oButton_draw()
    love.graphics.draw(checkbox, 185, 251)    
    sound_bars()
  end
  
  -----------Physics--------
  --love.graphics.setColor(72, 160, 14)
  --love.graphics.polygon("fill", objects.character.body:getWorldPoints(objects.character.shape:getPoints()))
  -----------Physics--------
end

function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2)
  return x1 < x2 + w2 and
         x2 < x1 + w1 and
         y1 < y2 + h2 and
         y2 < y1 + h1
end

function love.mousepressed(x, y, button, isTouch)
  mousePress(x, y)
end

function love.mousereleased(x, y, button, isTouch)
  mouseReleased()
end

function charSelection()
  if charSel == 1 then
      love.graphics.rectangle("fill",30 * scaleX, 130 * scaleY, 80 * scaleX, 116 * scaleY)
    end
    if charSel == 2 then
      love.graphics.rectangle("fill",150 * scaleX, 130 * scaleY, 80 * scaleX, 116 * scaleY)
    end
    if charSel == 3 then
      love.graphics.rectangle("fill",30 * scaleX, 280 * scaleY, 80 * scaleX, 116 * scaleY)
    end
    if charSel == 4 then
      love.graphics.rectangle("fill",150 * scaleX, 280 * scaleY, 80 * scaleX, 116 * scaleY)
    end
  end

-------Physics------
function beginContact(a, b, coll)
  x,y = coll:getNormal()
end
 
function endContact(a, b, coll)
  persisting = 0
end
 
function preSolve(a, b, coll)
  persisting = persisting + 1
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end
-------Physics------