dButton = {}

function dButton_spawn(x,y,text,id)
    table.insert(dButton, {x = x, y = y, text = text, id = id, mouseovertext = false})
end
  
function dButton_draw()
  for i,v in ipairs(dButton) do
    if v.mouseovertext == true then
      love.graphics.setColor(232,232,232)
    end
    if v.mouseovertext == false then
      love.graphics.setColor(0,255,233)
    end
    love.graphics.setFont(font)
      love.graphics.print(v.text,v.x,v.y)
  end
  love.graphics.setColor(255,255,255)
end
  
function dButton_click(x,y)
  for i,v in ipairs(dButton) do
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
          gamestate = "intermediate"
        end
        if v.id == "3" then
          gamestate = "advanced"
        end
        if v.id == "4" then
          gamestate = "menu"
        end
    end            
  end
end

function dButton_check()
  for i,v in ipairs(dButton) do
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