screen_padding = 10
default_speed = 2

pad1 = {}
pad1.x = screen_padding
pad1.y = screen_padding
pad1.width = 20
pad1.height = 80

pad2 = {}
pad2.y = screen_padding
pad2.width = 20
pad2.height = 80

ball = {}
ball.width = 20
ball.height = 20
ball.speed_x = default_speed
ball.speed_y = default_speed

function love.load()
    -- Set in load() because getWidth() and getHeight() are initialized here
    pad2.x = love.graphics.getWidth() - pad2.width - screen_padding

    ball.x = love.graphics.getWidth() / 2 - ball.width / 2
    ball.y = love.graphics.getHeight() / 2 - ball.height / 2
end

function love.update(dt)
    -- PAD 1 CONTROLS
    -- "E" for up and "C" for down, because they are at the same place on both QWERTY and AZERTY keyboards
    if love.keyboard.isDown("e") and pad1.y > screen_padding then
        pad1.y = pad1.y - default_speed
    end
    if love.keyboard.isDown("c") and pad1.y < love.graphics.getHeight() - pad1.height - screen_padding then
        pad1.y = pad1.y + default_speed
    end

    -- PAD 2 CONTROLS
    -- "Up arrow" and "Down arrow"
    if love.keyboard.isDown("up") and pad2.y > screen_padding then
        pad2.y = pad2.y - default_speed
    end
    if love.keyboard.isDown("down") and pad2.y < love.graphics.getHeight() - pad2.height - screen_padding then
        pad2.y = pad2.y + default_speed
    end

    -- BOUNCE THE BALL AGAINST THE WALLS
    -- Invert the x speed if the left wall is touched
    if ball.speed_x ~= default_speed and ball.x <= screen_padding then
        ball.speed_x = -ball.speed_x
    end
    -- Invert the x speed if the right wall is touched
    if ball.speed_x == default_speed and ball.x >= love.graphics.getWidth() - ball.width - screen_padding then
        ball.speed_x = -ball.speed_x
    end
    -- Invert the y speed if the top wall is touched
    if ball.speed_y ~= default_speed and ball.y <= screen_padding then
        ball.speed_y = -ball.speed_y
    end
    -- Invert the y speed if the bottom wall is touched
    if ball.speed_y == default_speed and ball.y >= love.graphics.getHeight() - ball.height - screen_padding then
        ball.speed_y = -ball.speed_y
    end

    -- Move
    ball.x = ball.x + ball.speed_x
    ball.y = ball.y + ball.speed_y
end

function love.draw()
    love.graphics.rectangle("line", screen_padding, screen_padding, love.graphics.getWidth() - screen_padding * 2, love.graphics.getHeight() - screen_padding * 2)
    love.graphics.rectangle("fill", pad1.x, pad1.y, pad1.width, pad1.height)
    love.graphics.rectangle("fill", pad2.x, pad2.y, pad2.width, pad2.height)
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end

