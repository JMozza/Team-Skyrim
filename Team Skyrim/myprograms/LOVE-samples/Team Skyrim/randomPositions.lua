function heightGen(bottomLevel, toplevel) -- this function is used for the positions of the collectables upon level creation
  random2 = math.random(bottomLevel, toplevel)
  
  if random2 == 1 then
    colY = 50
  end
  if random2 == 2 then
    colY = 100
  end
  if random2 == 3 then
    colY = 150
  end
  
  return colY
end

function widthGen(startWidth, endWidth) -- this function is used for the positions of the collectables upon level creation
  random = math.random(startWidth, endWidth)
end

function validateRandom(x, y)
  for i,v in ipairs(collectables) do
    if v.X == x then
      if v.Y == y then
        return false
      end
    end
  end
  
  return true
end

--for i = 3, 10 do
--  if (usedXPos[i] - random2) <= 50 then
--    widthGen(0, 200) -- set these to the start and end of the platforms
--    heightGen(0, 200)
--  end
--end