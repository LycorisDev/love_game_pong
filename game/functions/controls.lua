function love.keypressed(key, scancode, isrepeat)
	-- Pause with "Space" which is easily accessible by both players
	if key == "space" then
		pause_game = not pause_game
	elseif not pause_game then
		-- Restart with "Escape" (supposedly pressed by player 1)
		if key == "escape" then
			start_game(1)
		-- Restart with "Enter" (supposedly pressed by player 2)
		elseif key == "return" then
			start_game(2)
		end
	end
end

function ctrl_player1(dt)
	-- "E" for up and "C" for down, because they are at the same place on both 
	-- QWERTY and AZERTY keyboards
	if love.keyboard.isDown("e") and pad1.y > screen_padding then
		pad1.y = pad1.y - pad_speed * dt
	end
	if love.keyboard.isDown("c") and
	pad1.y < love.graphics.getHeight() - screen_padding - pad1.height then
		pad1.y = pad1.y + pad_speed * dt
	end
end

function ctrl_player2(dt)
	-- "Up arrow" and "Down arrow"
	if love.keyboard.isDown("up") and pad2.y > screen_padding then
		pad2.y = pad2.y - pad_speed * dt
	end
	if love.keyboard.isDown("down") and
	pad2.y < love.graphics.getHeight() - screen_padding - pad2.height then
		pad2.y = pad2.y + pad_speed * dt
	end
end
