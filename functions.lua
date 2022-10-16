function start_game(nbr_player)
    score1 = 0
    score2 = 0

    center_pads()
    center_ball()

    -- Ball goes towards player 2
    if nbr_player == 1 then
        ball.speed_x = ball_speed
        ball.speed_y = ball_speed
    end
    -- Ball goes towards player 1
    if nbr_player == 2 then
        ball.speed_x = -ball_speed
        ball.speed_y = -ball_speed
    end
end

function center_pads()
    pad1.y = love.graphics.getHeight() / 2 - pad1.height / 2
    pad2.y = love.graphics.getHeight() / 2 - pad2.height / 2
end

function center_ball()
    ball.x = love.graphics.getWidth() / 2 - ball.width / 2
    ball.y = love.graphics.getHeight() / 2 - ball.height / 2
end

function invert_ball_speed_x()
    ball.speed_x = -ball.speed_x
end

function invert_ball_speed_y()
    ball.speed_y = -ball.speed_y
end

