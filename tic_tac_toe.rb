require 'gosu'

class Square
  def initialize(center_x, center_y, square)
    @center_x = center_x
    @center_y = center_y
    @square = square
    @half_square = square/2
    @player = nil
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

  def hover?(x, y)
    Gosu.distance(x, y, @center_x, @center_y) < 50
  end

  def update(mouse_x, mouse_y)
    @highlighted = hover?(mouse_x, mouse_y)
  end

  def handle_click(mouse_x, mouse_y, player)
    if hover?(mouse_x, mouse_y) && @player == nil
      @player = player
      return true
    else
      return false
    end
  end

  def player
    @player
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

  def handle_click(mouse_x, mouse_y, player)
    @grid.each do |line|
      line.each do |square|
        return true if square.handle_click(mouse_x, mouse_y, player)
      end
    end

    return false
  end

  def owner?(a, b, c)
    player = a.player
    if player != nil && player == b.player && player == c.player
      return player
    else
      return nil
    end
  end

  def winner?
    # horizontal
    @grid.each do |line|
      player = owner?(line[0], line[1], line[2])
      return player if player != nil
    end

    # vertical
    0.upto(2) do |col|
      player = owner?(@grid[0][col], @grid[1][col], @grid[2][col])
      return player if player != nil
    end

    # diagonal 1
    player = owner?(@grid[0][0], @grid[1][1], @grid[2][2])
    return player if player != nil

    # diagonal 2
    owner?(@grid[0][2], @grid[1][1], @grid[2][0])
  end

  def filled?
    free_count = 0
    @grid.each do |line|
      line.each do |square|
        free_count += 1 if square.player == nil
      end
    end

    return free_count == 0
  end

  def over?
    return winner? || filled?
  end
end

class TicTacToe < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Tic Tac Toe'
    @grid = Grid.new(width, height)
    @player = 1
    @playing = true
    @font = Gosu::Font.new(30)
  end

  def draw
    draw_rect(0, 0, width, height, Gosu::Color::WHITE)
    @grid.draw

    unless @playing
      @font.draw_text('Game Over', 330, 50, 3, 1, 1, Gosu::Color::BLUE)
      @font.draw_text('Press space to play again', 240, 500, 3, 1, 1, Gosu::Color::BLUE)
    end
  end

  def update
    @grid.update(mouse_x, mouse_y)
    if @playing && @grid.over?
      @playing = false
    end
  end

  def next_player
    if @player == 1
      @player = 2
    else
      @player = 1
    end
  end

  def button_down(id)
    if @playing
      if id == Gosu::MsLeft
        next_player() if @grid.handle_click(mouse_x, mouse_y, @player)
      end
    else
      if id == Gosu::KbSpace
        @grid = Grid.new(width, height)
        @playing = true
      end
    end
  end
end

window = TicTacToe.new
window.show
