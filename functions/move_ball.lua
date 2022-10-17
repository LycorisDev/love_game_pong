function invert_ball_speed_x()
    ball.speed_x = -ball.speed_x
end

function invert_ball_speed_y()
    ball.speed_y = -ball.speed_y
end

function move_ball(dt)
    -- BOUNCE THE BALL AGAINST THE LEFT SIDE OF THE SCREEN
    if ball.speed_x ~= ball_speed then
        if ball.x <= pad1.x + pad1.width and ball.y + ball.height >= pad1.y and ball.y <= pad1.y + pad1.height then
            -- FIRST PAD IS TOUCHED
            love.audio.play(snd_hit)
            invert_ball_speed_x()
        elseif ball.x <= screen_padding then
            -- LEFT WALL IS TOUCHED
            love.audio.play(snd_lose)
            score2 = score2 + 1
            invert_ball_speed_x()
        end
    end

    -- BOUNCE THE BALL AGAINST THE RIGHT SIDE OF THE SCREEN
    if ball.speed_x == ball_speed then
        if ball.x + ball.width >= pad2.x and ball.y + ball.height >= pad2.y and ball.y <= pad2.y + pad2.height then
            -- SECOND PAD IS TOUCHED
            love.audio.play(snd_hit)
            invert_ball_speed_x()
        elseif ball.x + ball.width >= love.graphics.getWidth() - screen_padding then
            -- RIGHT WALL IS TOUCHED
            love.audio.play(snd_lose)
            score1 = score1 + 1
            invert_ball_speed_x()
        end
    end

    -- BOUNCE THE BALL AGAINST THE TOP SIDE OF THE SCREEN
    if ball.speed_y ~= ball_speed then
        if ball.y <= screen_padding then
            -- TOP WALL IS TOUCHED
            invert_ball_speed_y()
        end
    end

    -- BOUNCE THE BALL AGAINST THE BOTTOM SIDE OF THE SCREEN
    if ball.speed_y == ball_speed then
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

    for i = #arr_ball_trail, 1, -1 do
        local trail = arr_ball_trail[i]
        -- Decrease the element's "life"
        trail.life = trail.life - dt
        -- If life has reached 0, remove the element
        if trail.life < 0 then
            table.remove(arr_ball_trail, i)
        end
    end
end

