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
end

function love.draw()
    love.graphics.rectangle("fill", pad1.x, pad1.y, pad1.width, pad1.height)
    love.graphics.rectangle("fill", pad2.x, pad2.y, pad2.width, pad2.height)
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end

