function ctrl_restart()
    -- RESTART WITH "ESCAPE" (supposedly pressed by player 1)
    if love.keyboard.isDown("escape") then
        start_game(1)
    end
    -- RESTART WITH "ENTER" (supposedly pressed player 2)
    if love.keyboard.isDown("return") then
        start_game(2)
    end
end

function ctrl_player1()
    -- "E" for up and "C" for down, because they are at the same place on both QWERTY and AZERTY keyboards
    if love.keyboard.isDown("e") and pad1.y > screen_padding then
        pad1.y = pad1.y - pad_speed
    end
    if love.keyboard.isDown("c") and pad1.y < love.graphics.getHeight() - screen_padding - pad1.height then
        pad1.y = pad1.y + pad_speed
    end
end

function ctrl_player2()
    -- "Up arrow" and "Down arrow"
    if love.keyboard.isDown("up") and pad2.y > screen_padding then
        pad2.y = pad2.y - pad_speed
    end
    if love.keyboard.isDown("down") and pad2.y < love.graphics.getHeight() - screen_padding - pad2.height then
        pad2.y = pad2.y + pad_speed
    end
end

