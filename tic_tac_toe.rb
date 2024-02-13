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

    @grid = [[1, 2, 1], [2, 1, 2], [1, 2, 1]]
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

    @grid.each_index do |y|
      @grid[y].each_index do |x|
        if @grid[y][x] == 1
          draw_player1(x, y)
        elsif @grid[y][x] == 2
          draw_player2(x, y)
        end
      end
    end
  end

  def top_left_grid_x
    @center_x-@half_line
  end

  def top_left_grid_y
    @center_y-@half_line
  end
  
  def square_center_x(x)
    top_left_grid_x + x*@square + @half_square
  end

  def square_center_y(y)
    top_left_grid_y + y*@square + @half_square
  end

  def draw_player1(x, y)
    center_x = square_center_x(x)
    center_y = square_center_y(y)
    draw_rect(center_x-30, center_y-30, 60, 60, Gosu::Color::BLACK)
  end

  def draw_player2(x, y)
    center_x = square_center_x(x)
    center_y = square_center_y(y)
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
