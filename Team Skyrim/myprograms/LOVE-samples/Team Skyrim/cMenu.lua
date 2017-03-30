cButton = {}

function cButton_spawn(x,y,text,id)
    table.insert(cButton, {x = x, y = y, text = text, id = id, mouseovertext = false})
end
  
function cButton_draw()
  for i,v in ipairs(cButton) do
    if v.mouseovertext == true then
      love.graphics.setColor(232,232,232)
    end
    if v.mouseovertext == false then
      love.graphics.setColor(255,0,255)
    end
    love.graphics.setFont(font)
      love.graphics.print(v.text,v.x,v.y)
  end
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle("line",30 * scaleX, 130 * scaleY, 80 * scaleX, 116 * scaleY)
  love.graphics.rectangle("line",150 * scaleX, 130 * scaleY, 80 * scaleX, 116 * scaleY)
  love.graphics.rectangle("line",30 * scaleX, 280 * scaleY, 80 * scaleX, 116 * scaleY)
  love.graphics.rectangle("line",150 * scaleX, 280 * scaleY, 80 * scaleX, 116 * scaleY)
end
  
function cButton_click(x,y)
  for i,v in ipairs(cButton) do
    if x > v.x and
      x < v.x + font:getWidth(v.text) and
      y > v.y and
      y < v.y + font:getHeight() then
        if v.id == "1" then
          gamestate = "menu"
        end
        if v.id == "2" then 
          charSel = 1
        end
        if v.id == "3" then
          charSel = 2
        end
        if v.id == "4" then
          charSel = 3
        end
        if v.id == "5" then
          charSel = 4
        end
    end            
  end
end

function cButton_check()
  for i,v in ipairs(cButton) do
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