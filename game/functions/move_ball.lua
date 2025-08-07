function move_ball(dt)
	-- MOVE THE BALL
	ball.x = ball.x + ball.dx * dt
	ball.y = ball.y + ball.dy * dt

	-- BOUNCE THE BALL AGAINST THE LEFT SIDE OF THE SCREEN
	if ball.dx < 0 then
		if ball.x <= pad1.x + pad1.width and ball.y + ball.height >= pad1.y and
		ball.y <= pad1.y + pad1.height then
			-- FIRST PAD IS TOUCHED
			love.audio.stop(snd_hit)
			love.audio.play(snd_hit)
			ball.dx = -ball.dx
		elseif ball.x <= screen_padding then
			-- LEFT WALL IS TOUCHED
			love.audio.stop(snd_lose)
			love.audio.play(snd_lose)
			score2 = score2 + 1
			ball.dx = -ball.dx
		end
	end

	-- BOUNCE THE BALL AGAINST THE RIGHT SIDE OF THE SCREEN
	if ball.dx > 0 then
		if ball.x + ball.width >= pad2.x and ball.y + ball.height >= pad2.y and
		ball.y <= pad2.y + pad2.height then
			-- SECOND PAD IS TOUCHED
			love.audio.stop(snd_hit)
			love.audio.play(snd_hit)
			ball.dx = -ball.dx
		elseif ball.x + ball.width >= love.graphics.getWidth() - screen_padding
		then
			-- RIGHT WALL IS TOUCHED
			love.audio.stop(snd_lose)
			love.audio.play(snd_lose)
			score1 = score1 + 1
			ball.dx = -ball.dx
		end
	end

	-- BOUNCE THE BALL AGAINST THE TOP SIDE OF THE SCREEN
	if ball.dy < 0 then
		if ball.y <= screen_padding then
			-- TOP WALL IS TOUCHED
			ball.dy = -ball.dy
		end
	end

	-- BOUNCE THE BALL AGAINST THE BOTTOM SIDE OF THE SCREEN
	if ball.dy > 0 then
		if ball.y + ball.height >= love.graphics.getHeight() - screen_padding
		then
			-- TOP WALL IS TOUCHED
			ball.dy = -ball.dy
		end
	end
end
