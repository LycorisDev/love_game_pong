function get_dec_from_hex(hex)
	if tonumber(hex) then
		return tonumber(hex)
	elseif hex == "A" then
		return 10
	elseif hex == "B" then
		return 11
	elseif hex == "C" then
		return 12
	elseif hex == "D" then
		return 13
	elseif hex == "E" then
		return 14
	elseif hex == "F" then
		return 15
	else
		return 0
	end
end

function get_love_color(hex, alpha)
	local red = {}
	local green = {}
	local blue = {}
	local a = alpha or 1

	local arr = {}
	for i = 1, #hex do
		arr[i] = hex:sub(i, i)
	end

	table.insert(red, get_dec_from_hex(arr[1]))
	table.insert(red, get_dec_from_hex(arr[2]))
	table.insert(green, get_dec_from_hex(arr[3]))
	table.insert(green, get_dec_from_hex(arr[4]))
	table.insert(blue, get_dec_from_hex(arr[5]))
	table.insert(blue, get_dec_from_hex(arr[6]))

	red = (red[1] * 16 + red[2]) / 255
	green = (green[1] * 16 + green[2]) / 255
	blue = (blue[1] * 16 + blue[2]) / 255

	return { red, green, blue, a }
end

-- Taken from https://love2d.org/wiki/LineStippleSnippet
function draw_dashed_line(x1, y1, x2, y2, dash, gap)
	local dash = dash or 10
	local gap = gap or 10

	local steep = math.abs(y2 - y1) > math.abs(x2 - x1)
	if steep then
		x1, y1 = y1, x1
		x2, y2 = y2, x2
	end
	if x1 > x2 then
		x1, x2 = x2, x1
		y1, y2 = y2, y1
	end

	local dx = x2 - x1
	local dy = math.abs(y2 - y1)
	local err = dx / 2
	local ystep = (y1 < y2) and 1 or -1
	local y = y1
	local max_x = x2
	local pixel_count = 0
	local is_dash = true
	local last_a, last_b, a, b

	for x = x1, max_x do
		pixel_count = pixel_count + 1
		if (is_dash and pixel_count == gap) or
		(not is_dash and pixel_count == dash) then
			pixel_count = 0
			is_dash = not is_dash
			a = steep and y or x
			b = steep and x or y
			if last_a then
				love.graphics.line(last_a, last_b, a, b)
				last_a = nil
				last_b = nil
			else
				last_a = a
				last_b = b
			end
		end

		err = err - dy
		if err < 0 then
			y = y + ystep
			err = err + dx
		end
	end
end

function draw_middle_line()
	love.graphics.setLineWidth(2)
	love.graphics.setColor(get_love_color("3A69A5"))

	draw_dashed_line(love.graphics.getWidth() / 2, screen_padding,
		love.graphics.getWidth() / 2,
		love.graphics.getHeight() - screen_padding, 4, 8)
end

function draw_screen_padding()
	love.graphics.setLineWidth(4)
	love.graphics.setColor(get_love_color("3A69A5"))

	love.graphics.rectangle("line", screen_padding, screen_padding,
		love.graphics.getWidth() - screen_padding * 2,
		love.graphics.getHeight() - screen_padding * 2)
end

function draw_corners()
	love.graphics.setLineWidth(4)
	love.graphics.setColor(get_love_color("3A69A5"))

	love.graphics.rectangle("line", 1, 1, screen_padding - 1,
		screen_padding - 1)
	love.graphics.rectangle("line", love.graphics.getWidth() - screen_padding,
		1, screen_padding - 1, screen_padding - 1)
	love.graphics.rectangle("line", love.graphics.getWidth() - screen_padding,
		love.graphics.getHeight() - screen_padding, screen_padding - 1,
		screen_padding - 1)
	love.graphics.rectangle("line", 1,
		love.graphics.getHeight() - screen_padding, screen_padding - 1,
		screen_padding - 1)
end

function draw_score()
	love.graphics.setColor(get_love_color("CDE2FC"))

	local font = love.graphics.getFont()
	local score = score1.."   "..score2
	love.graphics.print(score,
		love.graphics.getWidth() / 2 - font:getWidth(score) / 2, 5)
end

function draw_ball()
	love.graphics.setLineWidth(4)
	love.graphics.setColor(get_love_color("CDE2FC"))

	love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end

function draw_pads()
	love.graphics.setLineWidth(4)
	love.graphics.setColor(get_love_color("75AFA5"))

	love.graphics.rectangle("fill", pad1.x, pad1.y, pad1.width, pad1.height)
	love.graphics.rectangle("fill", pad2.x, pad2.y, pad2.width, pad2.height)
end

function draw_ball_trail()
	local num_ghosts = 20
	local spacing = 0.02
	local ghost_x = ball.x
	local ghost_y = ball.y
	local vx = -ball.dx
	local vy = -ball.dy

	for i = 1, num_ghosts do
		local next_x = ghost_x + vx * spacing
		local next_y = ghost_y + vy * spacing

		if vx < 0 then
			if next_x <= pad1.x + pad1.width and next_y + ball.height >= pad1.y
			and next_y <= pad1.y + pad1.height then
				vx = -vx
				next_x = pad1.x + pad1.width + (pad1.x + pad1.width - next_x)
			elseif next_x <= screen_padding then
				vx = -vx
				next_x = screen_padding + (screen_padding - next_x)
			end
		end
		if vx > 0 then
			if next_x + ball.width >= pad2.x and next_y + ball.height >= pad2.y
			and next_y <= pad2.y + pad2.height then
				vx = -vx
				next_x = pad2.x - ball.width - ((next_x + ball.width) - pad2.x)
			elseif next_x + ball.width >= love.graphics.getWidth()
			- screen_padding then
				vx = -vx
				next_x = (love.graphics.getWidth() - screen_padding) * 2
					- (next_x + ball.width) - ball.width
			end
		end
		if vy < 0 and next_y <= screen_padding then
			vy = -vy
			next_y = screen_padding + (screen_padding - next_y)
		end
		if vy > 0 and next_y + ball.height >= love.graphics.getHeight()
		- screen_padding then
			vy = -vy
			next_y = (love.graphics.getHeight() - screen_padding) * 2
				- (next_y + ball.height) - ball.height
		end

		ghost_x = next_x
		ghost_y = next_y

		local alpha = (1 - (i / num_ghosts)) / 3
		love.graphics.setColor(get_love_color("CDE2FC", alpha))
		love.graphics.rectangle("fill", ghost_x, ghost_y, ball.width,
			ball.height)
	end
end

function draw_commands()
	love.graphics.setColor(get_love_color("CDE2FC"))

	local font = love.graphics.getFont()
	local str = {}
	table.insert(str, "- - PAUSED - -")
	table.insert(str, "Press SPACE to pause")
	table.insert(str, "\n")
	table.insert(str, "Player 1: E for up and C for down.")
	table.insert(str, "Player 2: UP ARROW and DOWN ARROW.")
	table.insert(str, "\n")
	table.insert(str, "Press ESCAPE or ENTER to restart,")
	table.insert(str, "this will not pause the game.")
	local height = 7
	for i = 1, #str do
		love.graphics.print(str[i],
			love.graphics.getWidth() / 2 - font:getWidth(str[i]) / 2, height)
		height = height + font:getHeight(str[i]) + 7
	end
end
