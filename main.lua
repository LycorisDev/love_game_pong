require("functions")

screen_padding = 10
default_speed = 3

score1 = 0
score2 = 0

pad1 = {}
pad1.x = screen_padding
-- pad1.y
pad1.width = 20
pad1.height = 80

pad2 = {}
-- pad2.x
-- pad2.y
pad2.width = 20
pad2.height = 80

ball = {}
-- ball.x
-- ball.y
ball.width = 20
ball.height = 20
ball.speed_x = default_speed
ball.speed_y = default_speed

arr_ball_trail = {}

function love.load()
    -- Load resources in
    love.graphics.setFont(love.graphics.newFont("PixelMaster.ttf", 60))
    snd_hit = love.audio.newSource("snd_hit.mp3", "static")
    snd_lose = love.audio.newSource("snd_lose.mp3", "static")

    -- Initialize window
    love.window.setTitle('PONG')

    -- Initialize data
    pad2.x = love.graphics.getWidth() - screen_padding - pad2.width
    start_game(1)
end

function love.update(dt)
    -- START AGAIN WITH "ESCAPE" (supposedly pressed by player 1)
    if love.keyboard.isDown("escape") then
        start_game(1)
    end
    -- START AGAIN WITH "ENTER" (supposedly pressed player 2)
    if love.keyboard.isDown("return") then
        start_game(2)
    end

    -- PAD 1 CONTROLS
    -- "E" for up and "C" for down, because they are at the same place on both QWERTY and AZERTY keyboards
    if love.keyboard.isDown("e") and pad1.y > screen_padding then
        pad1.y = pad1.y - default_speed
    end
    if love.keyboard.isDown("c") and pad1.y < love.graphics.getHeight() - screen_padding - pad1.height then
        pad1.y = pad1.y + default_speed
    end

    -- PAD 2 CONTROLS
    -- "Up arrow" and "Down arrow"
    if love.keyboard.isDown("up") and pad2.y > screen_padding then
        pad2.y = pad2.y - default_speed
    end
    if love.keyboard.isDown("down") and pad2.y < love.graphics.getHeight() - screen_padding - pad2.height then
        pad2.y = pad2.y + default_speed
    end

    -- BOUNCE THE BALL AGAINST THE LEFT SIDE OF THE SCREEN
    if ball.speed_x ~= default_speed then
        if ball.x <= pad1.x + pad1.width and ball.y + ball.height >= pad1.y and ball.y <= pad1.y + pad1.height then
            -- FIRST PAD IS TOUCHED
            love.audio.play(snd_hit)
            invert_ball_speed_x()
        end
        if ball.x <= screen_padding then
            -- LEFT WALL IS TOUCHED
            love.audio.play(snd_lose)
            score2 = score2 + 1
            invert_ball_speed_x()
        end
    end

    -- BOUNCE THE BALL AGAINST THE RIGHT SIDE OF THE SCREEN
    if ball.speed_x == default_speed then
        if ball.x + ball.width >= pad2.x and ball.y + ball.height >= pad2.y and ball.y <= pad2.y + pad2.height then
            -- SECOND PAD IS TOUCHED
            love.audio.play(snd_hit)
            invert_ball_speed_x()
        end
        if ball.x + ball.width >= love.graphics.getWidth() - screen_padding then
            -- RIGHT WALL IS TOUCHED
            love.audio.play(snd_lose)
            score1 = score1 + 1
            invert_ball_speed_x()
        end
    end

    -- BOUNCE THE BALL AGAINST THE TOP SIDE OF THE SCREEN
    if ball.speed_y ~= default_speed then
        if ball.y <= screen_padding then
            -- TOP WALL IS TOUCHED
            invert_ball_speed_y()
        end
    end

    -- BOUNCE THE BALL AGAINST THE BOTTOM SIDE OF THE SCREEN
    if ball.speed_y == default_speed then
        if ball.y + ball.height >= love.graphics.getHeight() - screen_padding then
            -- TOP WALL IS TOUCHED
            invert_ball_speed_y()
        end
    end

    -- MOVE THE BALL
    ball.x = ball.x + ball.speed_x
    ball.y = ball.y + ball.speed_y

    -- ADD A TRAIL EFFECT TO THE BALL
    -- Add a ball "ghost" to the trail array
    local ball_trail = {}
    ball_trail.x = ball.x
    ball_trail.y = ball.y
    ball_trail.life = 0.5
    table.insert(arr_ball_trail, ball_trail)

    for n = #arr_ball_trail, 1, -1 do
        local trail = arr_ball_trail[n]
        -- Decrease the element's "life"
        trail.life = trail.life - dt
        -- If life has reached 0, remove the element
        if trail.life < 0 then
            table.remove(arr_ball_trail, n)
        end
    end
end

function love.draw()
    -- Padding
    love.graphics.rectangle("line", screen_padding, screen_padding, love.graphics.getWidth() - screen_padding * 2, love.graphics.getHeight() - screen_padding * 2)
    -- Middle line
    love.graphics.setLineWidth(4)
    love.graphics.line(love.graphics.getWidth() / 2, screen_padding + 1, love.graphics.getWidth() / 2, love.graphics.getHeight() - screen_padding - 1)
    -- Score
    local font = love.graphics.getFont()
    local score = score1.."   "..score2
    love.graphics.print(score, love.graphics.getWidth() / 2 - font:getWidth(score) / 2, 5)
    -- Elements
    love.graphics.rectangle("fill", pad1.x, pad1.y, pad1.width, pad1.height)
    love.graphics.rectangle("fill", pad2.x, pad2.y, pad2.width, pad2.height)
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
    -- Ball trail
    for n = 1, #arr_ball_trail do
        local ghost = arr_ball_trail[n]
        -- Set the opacity: <= 0.5, then divided by 2 because it's too intense
        local alpha = ghost.life / 2
        -- Color for the trail
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.rectangle("fill", ghost.x, ghost.y, ball.width, ball.height)
    end

    -- Color for everything
    love.graphics.setColor(1, 1, 1, 1)
end

