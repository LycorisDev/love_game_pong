pause_game = true

screen_padding = 10
pad_speed = 5
ball_speed = 3

score1 = 0
score2 = 0

pad1 = {}
pad2 = {}
ball = {}
arr_ball_trail = {}

function initialize_window()
    love.window.setTitle('PONG')
end

function load_resources_in()
    love.graphics.setFont(love.graphics.newFont("/media/fonts/PixelMaster.ttf", 60))
    snd_hit = love.audio.newSource("/media/sounds/snd_hit.mp3", "static")
    snd_lose = love.audio.newSource("/media/sounds/snd_lose.mp3", "static")
end

function initialize_data()
    pause_game = true

    pad1.width = 20
    pad1.height = 80
    pad1.x = screen_padding
    -- pad1.y: in center_pads()

    pad2.width = 20
    pad2.height = 80
    pad2.x = love.graphics.getWidth() - screen_padding - pad2.width
    -- pad2.y: in center_pads()

    ball.width = 20
    ball.height = 20
    -- ball.x: in center_ball()
    -- ball.y: in center_ball()
    -- ball.speed_x: in ball_sent_to_the_right() / ball_sent_to_the_left()
    -- ball.speed_y: in ball_sent_to_the_right() / ball_sent_to_the_left()

    start_game(1)
end

function start_game(nbr_player)
    reset_score()
    center_pads()
    center_ball()

    if nbr_player == 1 then
        ball_sent_to_the_right()
    else
        ball_sent_to_the_left()
    end
end

function reset_score()
    score1 = 0
    score2 = 0
end

function center_pads()
    pad1.y = love.graphics.getHeight() / 2 - pad1.height / 2
    pad2.y = love.graphics.getHeight() / 2 - pad2.height / 2
end

function center_ball()
    ball.x = love.graphics.getWidth() / 2 - ball.width / 2
    ball.y = love.graphics.getHeight() / 2 - ball.height / 2
end

function ball_sent_to_the_right()
    ball.speed_x = ball_speed
    ball.speed_y = ball_speed
end

function ball_sent_to_the_left()
    ball.speed_x = -ball_speed
    ball.speed_y = -ball_speed
end

