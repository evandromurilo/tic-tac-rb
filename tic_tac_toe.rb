require 'gosu'

class Square
  def initialize(center_x, center_y, square)
    @center_x = center_x
    @center_y = center_y
    @square = square
    @half_square = square/2
    @player = 1
    @highlighted = false
  end

  def draw
    if @highlighted
      margin = 10
      Gosu::draw_rect(@center_x-@half_square+margin, @center_y-@half_square+margin, @square-margin*2, @square-margin*2, Gosu::Color::GRAY)
    end
    
    if @player == 1
      Gosu::draw_rect(@center_x-30, @center_y-30, 60, 60, Gosu::Color::BLACK)
    elsif @player == 2
      Gosu::draw_triangle(@center_x, @center_y-30, Gosu::Color::BLACK,
                          @center_x-30, @center_y+30, Gosu::Color::BLACK,
                          @center_x+30, @center_y+30, Gosu::Color::BLACK)
    end
  end

  def update(mouse_x, mouse_y)
    @highlighted = Gosu.distance(mouse_x, mouse_y, @center_x, @center_y) < 50
  end
end

class Grid
  def initialize(w, h)
    @center_x = w/2
    @center_y = h/2
    @square = 120
    @line = @square*3
    @half_line = @line/2
    @half_square = @square/2
    @grid = []

    0.upto(2) do |y|
      line = []
      0.upto(2) do |x|
        line.push(Square.new(square_center_x(x), square_center_y(y), @square))
      end
      @grid.push(line)
    end
  end

  def offset_x(length)
    @center_x + length
  end

  def offset_y(length)
    @center_y + length
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

  def draw
    Gosu::draw_rect(@center_x-@half_square, @center_y-@half_line, 2, @line, Gosu::Color::BLACK)
    Gosu::draw_rect(@center_x+@half_square, @center_y-@half_line, 2, @line, Gosu::Color::BLACK)

    Gosu::draw_rect(@center_x-@half_line, @center_y-@half_square, @line, 2, Gosu::Color::BLACK)
    Gosu::draw_rect(@center_x-@half_line, @center_y+@half_square, @line, 2, Gosu::Color::BLACK)
    
    @grid.each do |line|
      line.each do |square|
        square.draw
      end
    end
  end

  def update(mouse_x, mouse_y)
    @grid.each do |line|
      line.each do |square|
        square.update(mouse_x, mouse_y)
      end
    end
  end
end

class TicTacToe < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Tic Tac Toe'
    @grid = Grid.new(width, height)
  end

  def draw
    draw_rect(0, 0, width, height, Gosu::Color::WHITE)
    @grid.draw
  end

  def update
    @grid.update(mouse_x, mouse_y)
  end
end

window = TicTacToe.new
window.show
