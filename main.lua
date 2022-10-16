default_speed = 2

pad1 = {}
pad1.x = 0
pad1.y = 0
pad1.width = 20
pad1.height = 80

pad2 = {}
pad2.y = 0
pad2.width = 20
pad2.height = 80

ball = {}
ball.width = 20
ball.height = 20

function love.load()
    -- Set in load() because getWidth() and getHeight() are initialized here
    pad2.x = love.graphics.getWidth() - pad2.width

    ball.x = love.graphics.getWidth() / 2 - ball.width / 2
    ball.y = love.graphics.getHeight() / 2 - ball.height / 2
end

function love.update(dt)
    -- Pad 1 controls
    -- "E" for up and "C" for down, because they are at the same place on both QWERTY and AZERTY keyboards
    if love.keyboard.isDown("e") and pad1.y > 0 then
        pad1.y = pad1.y - default_speed
    end
    if love.keyboard.isDown("c") and pad1.y < love.graphics.getHeight() - pad1.height then
        pad1.y = pad1.y + default_speed
    end

    -- Pad 2 controls
    -- "Up arrow" and "Down arrow"
    if love.keyboard.isDown("up") and pad2.y > 0 then
        pad2.y = pad2.y - default_speed
    end
    if love.keyboard.isDown("down") and pad2.y < love.graphics.getHeight() - pad2.height then
        pad2.y = pad2.y + default_speed
    end
end

function love.draw()
    love.graphics.rectangle("fill", pad1.x, pad1.y, pad1.width, pad1.height)
    love.graphics.rectangle("fill", pad2.x, pad2.y, pad2.width, pad2.height)
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end

