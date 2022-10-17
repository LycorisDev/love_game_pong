require("functions/init")
require("functions/controls")
require("functions/move_ball")
require("functions/graphics")

function love.load()
    initialize_window()
    load_resources_in()
    initialize_data()
end

function love.update(dt)
    ctrl_restart()
    ctrl_player1()
    ctrl_player2()
    move_ball(dt)
end

function love.draw()
    draw_screen_padding()
    draw_middle_line()
    draw_corners()
    draw_score()
    draw_pads()
    draw_ball()
    draw_ball_trail()
end

