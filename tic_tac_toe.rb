require 'gosu'

class TicTacToe < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Tic Tac Toe'

    @center_x = 800/2
    @center_y = 600/2
    @square = 120
    @line = @square*3
    @half_line = @line/2
    @half_square = @square/2
  end

  def offset_x(length)
    @center_x + length
  end

  def offset_y(length)
    @center_y + length
  end

  def draw
    draw_rect(0, 0, 800, 600, Gosu::Color::WHITE)
    draw_grid
    draw_player1(offset_x(-@square), offset_y(@square))
    draw_player2(@center_x, offset_y(@square))
  end

  def draw_player1(center_x, center_y)
    draw_rect(center_x-30, center_y-30, 60, 60, Gosu::Color::BLACK)
  end

  def draw_player2(center_x, center_y)
    draw_triangle(center_x, center_y-30, Gosu::Color::BLACK,
                  center_x-30, center_y+30, Gosu::Color::BLACK,
                  center_x+30, center_y+30, Gosu::Color::BLACK)
  end

  def draw_grid
    draw_rect(@center_x-@half_square, @center_y-@half_line, 2, @line, Gosu::Color::BLACK)
    draw_rect(@center_x+@half_square, @center_y-@half_line, 2, @line, Gosu::Color::BLACK)

    draw_rect(@center_x-@half_line, @center_y-@half_square, @line, 2, Gosu::Color::BLACK)
    draw_rect(@center_x-@half_line, @center_y+@half_square, @line, 2, Gosu::Color::BLACK)
  end
end

window = TicTacToe.new
window.show
