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

function heightGen(bottomLevel, toplevel) -- this function is used for the positions of the collectables upon level creation
  random2 = math.random(bottomLevel, toplevel)
end