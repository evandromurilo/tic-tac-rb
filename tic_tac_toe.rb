require 'gosu'

class TicTacToe < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Tic Tac Toe'
  end

  def draw
    draw_rect(0, 0, 800, 600, Gosu::Color::WHITE)
    draw_grid
  end

  def draw_grid
    center_x = 800/2
    center_y = 600/2
    square = 120
    line = square*3
    half_line = line/2
    half_square = square/2
    
    draw_rect(center_x-half_square, center_y-half_line, 2, line, Gosu::Color::BLACK)
    draw_rect(center_x+half_square, center_y-half_line, 2, line, Gosu::Color::BLACK)

    draw_rect(center_x-half_line, center_y-half_square, line, 2, Gosu::Color::BLACK)
    draw_rect(center_x-half_line, center_y+half_square, line, 2, Gosu::Color::BLACK)
  end
end

window = TicTacToe.new
window.show
