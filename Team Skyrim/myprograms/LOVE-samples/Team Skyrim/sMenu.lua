sButton = {}

function sButton_spawn(x,y,text,id)
    table.insert(sButton, {x = x, y = y, text = text, id = id, mouseovertext = false})
end
  
function sButton_draw()
  for i,v in ipairs(sButton) do
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
  
function sButton_click(x,y)
  for i,v in ipairs(sButton) do
    if x > v.x and
      x < v.x + font:getWidth(v.text) and
      y > v.y and
      y < v.y + font:getHeight() then
        if v.id == "1" then
          gamestate = "menu"
        end
    end            
  end
end

function sButton_check()
  for i,v in ipairs(sButton) do
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