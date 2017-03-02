button = {}

function button_spawn(x,y,text,id)
    table.insert(button, {x = x, y = y, text = text, id = id, mouseovertext = false})
end
  
function button_draw()
  for i,v in ipairs(button) do
    if v.mouseovertext == true then
      --love.graphics.setColor(32,32,32)
      love.graphics.setColor(232,232,232)
    end
    if v.mouseovertext == false then
      --love.graphics.setColor(57,58,64)
      love.graphics.setColor(255,0,25)
    end
    love.graphics.setFont(font)
    love.graphics.print(v.text,v.x,v.y)
  end
  love.graphics.setColor(255,255,255)
end
  
function button_click(x,y)
  for i,v in ipairs(button) do
    if x > v.x and
      x < v.x + font:getWidth(v.text) and
      y > v.y and
      y < v.y + font:getHeight() then
        if v.id == "1" then
          gamestate = "easy"
          startCount = 1
          objects.block1.body:applyAngularImpulse(-550)
          objects.block1.body:applyLinearImpulse(-535, -2000)
          objects.block2.body:applyAngularImpulse(555)
          objects.block2.body:applyLinearImpulse(520, -2000)
        end       
        if v.id == "2" then
          gamestate = "character"
        end
        if v.id == "3" then
          gamestate = "scoreboard"
        end
        if v.id == "4" then
          gamestate = "options"
        end
        if v.id == "5" then
          love.event.push("quit")
        end
    end            
  end
end

function button_check()
  for i,v in ipairs(button) do
    if mousex > v.x and
      mousex < v.x + font:getWidth(v.text) and
      mousey > v.y and
      mousey < v.y + font:getHeight() then
        v.mouseovertext = true
      else
        v.mouseovertext = false
    end
  end
end