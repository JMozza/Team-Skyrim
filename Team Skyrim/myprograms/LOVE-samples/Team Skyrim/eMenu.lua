eButton = {}

function eButton_spawn(x,y,text,id)
    table.insert(eButton, {x = x, y = y, text = text, id = id, mouseovertext = false})
end
  
function eButton_draw()
  for i,v in ipairs(eButton) do
    if v.mouseovertext == true then
      love.graphics.setColor(232,232,232)
    end
    if v.mouseovertext == false then
      love.graphics.setColor(0,255,12)
    end
    love.graphics.setFont(font)
      love.graphics.print(v.text,v.x,v.y)
  end
  love.graphics.setColor(255,255,255)
end
  
function eButton_click(x,y)
  for i,v in ipairs(eButton) do
    if x > v.x and
      x < v.x + font:getWidth(v.text) and
      y > v.y and
      y < v.y + font:getHeight() then
        if v.id == "1" then
          gamestate = "menu"
          --reload()
        end
    end            
  end
end

function eButton_check()
  for i,v in ipairs(eButton) do
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