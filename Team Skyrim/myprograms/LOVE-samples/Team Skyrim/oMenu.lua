oButton = {}

function oButton_spawn(x,y,text,id)
    table.insert(oButton, {x = x, y = y, text = text, id = id, mouseovertext = false})
end
  
function oButton_draw()
  for i,v in ipairs(oButton) do
    if v.mouseovertext == true then
      love.graphics.setColor(232,232,232)
    end
    if v.mouseovertext == false then
      love.graphics.setColor(255,131,0)
    end
    love.graphics.setFont(font)
    love.graphics.print(v.text,v.x,v.y)
  end
  love.graphics.setColor(255,255,255)
end
  
function oButton_click(x,y)
  for i,v in ipairs(oButton) do
    if x > v.x and
      x < v.x + font:getWidth(v.text) and
      y > v.y and
      y < v.y + font:getHeight() then
        if v.id == "1" then
          gamestate = "menu"
        end
        if v.id == "2" then
            --v_effects = v_effects - 0.1
            --if v_effects <= 0 then
              --v_effects = 0
            --end
        end
        if v.id == "3" then
            --v_effects = v_effects + 0.1
            --if v_effects >= 1 then
              --v_effects = 1
            --end
        end
        if v.id == "4" then
            --v_music = v_music - 0.1
            --if v_music <= 0 then
              --v_music = 0
            --end
        end
        if v.id == "5" then
            --v_music = v_music + 0.1
            --if v_music >= 1 then
              --v_music = 1
            --end
        end
        if v.id == "6" then
          --if v_music > 0 then
            --v_music = 0
            --level1Music:setVolume(v_music)
            --level2Music:setVolume(v_music)
          --else
            --v_music = 1
            --level1Music:setVolume(v_music)
            --level2Music:setVolume(v_music)
          --end
          --if v_effects > 0 then
            --v_effects = 0
            --wilhelm:setVolume(v_effects)
            --move:setVolume(v_effects)
          --else
            --v_effects = 1
            --wilhelm:setVolume(v_effects)
            --move:setVolume(v_effects)
          --end
        end
        if v.id == "7" then
          --love.system.openURL("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
        end
    end            
  end
end

function oButton_check()
  for i,v in ipairs(oButton) do
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