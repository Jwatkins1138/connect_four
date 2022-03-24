class Board

  attr_accessor :spaces, :game_on, :winner
  

  def initialize
    @spaces = Array.new(6)
    @spaces.map! { |x| x = Array.new(7) }
    @spaces.each { |x| x.map! { |y| y = Space.new } }
    @game_on = true
  end

  def game_state
    @game_on
  end

  def check_input(input)
    if (0..6).include?(input) && @spaces[0][input].value == nil
      return true
    else
      return false
    end
  end

  def check_placement(column)
    if @spaces[5][column].value == nil
      return 5
    elsif @spaces[4][column].value == nil
      return 4
    elsif @spaces[3][column].value == nil
      return 3
    elsif @spaces[2][column].value == nil
      return 2
    elsif @spaces[1][column].value == nil
      return 1
    elsif @spaces[0][column].value == nil
      return 0
    end
  end

  def set_white(row, column)
    space(row, column).set_white
  end

  def set_black(row, column)
    space(row, column).set_black
  end

  def space(row, column)
    @spaces[row][column]
  end
  
  def winner
    @winner
  end

  def draw_board
    @spaces.each { |x| 
      x.each { |y| print "[ #{y.draw_space}]"}
      print "\n"}
    
  end

  def check_horizontal
    count = 1
    row = 0
    column = 0
    while row < 6
      while column < 6
        if @spaces[row][column].value != nil && @spaces[row][column].value == @spaces[row][column + 1].value
          count += 1
          if count >= 4
            @game_on = false
            @winner = @spaces[row][column].value
          end
        else count = 1
        end
        column += 1
      end
      column = 0
      row += 1
    end
  end

  def check_vertical
    count = 1
    row = 0
    column = 0
    while column < 7
      while row < 5
        if @spaces[row][column].value != nil && @spaces[row][column].value == @spaces[row + 1][column].value
          count += 1
          if count >= 4
            @game_on = false
            @winner = @spaces[row][column].value
          end
        else count = 1
        end
        row += 1
      end
      row = 0
      column += 1
    end
  end

  def check_diagonal_down
    count = 1
    start_row = 2
    start_column = 0
    while start_row >= 0
      row = start_row
      column = start_column
      while @spaces[row] && @spaces[row][column] && @spaces[row + 1] && @spaces[row + 1][column + 1]
        if @spaces[row][column].value != nil && @spaces[row][column].value == @spaces[row + 1][column + 1].value
          count += 1
          if count >= 4
            @game_on = false
            @winner = @spaces[row][column].value
          end
        else 
          count = 1
        end
        row += 1
        column += 1
      end
      start_row -= 1
    end
    while start_column <= 3
      row = start_row
      column = start_column
      while @spaces[row] && @spaces[row][column] && @spaces[row + 1] && @spaces[row + 1][column + 1]
        if @spaces[row][column].value != nil && @spaces[row][column].value == @spaces[row + 1][column + 1].value
          count += 1
          if count >= 4
            @game_on = false
            @winner = @spaces[row][column].value
          end
        else 
          count = 1
        end
        row += 1
        column += 1
      end
      start_column += 1
    end
  end

  def check_diagonal_up 
    count = 1
    start_row = 2
    start_column = 6
    while start_row >= 0
      row = start_row
      column = start_column
      while @spaces[row] && @spaces[row][column] && @spaces[row + 1] && @spaces[row + 1][column - 1]
        if @spaces[row][column].value != nil && @spaces[row][column].value == @spaces[row + 1][column - 1].value
          count += 1
          if count >= 4
            @game_on = false
            @winner = @spaces[row][column].value
          end
        else 
          count = 1
        end
        row += 1
        column -= 1
      end
      start_row -= 1
    end
    while start_column >= 3
      row = start_row
      column = start_column
      while @spaces[row] && @spaces[row][column] && @spaces[row + 1] && @spaces[row + 1][column -1]
        if @spaces[row][column].value != nil && @spaces[row][column].value == @spaces[row + 1][column - 1].value
          count += 1
          if count >= 4
            @game_on = false
            @winner = @spaces[row][column].value
          end
        else 
          count = 1
        end
        row += 1
        column -= 1
      end
      start_column -= 1
    end
  end
     

  def white_move
    puts "white's turn, enter column number: "
    input = gets.chomp.to_i
    until check_input(input)
      puts "please enter a valid column number: "
      input = gets.chomp.to_i
    end
    set_white(check_placement(input), input)
  end

  def black_move
    puts "black's turn, enter column number: "
    input = gets.chomp.to_i
    until check_input(input)
      puts "please enter a valid column number: "
      input = gets.chomp.to_i
    end
    set_black(check_placement(input), input)
  end

  def check_state
    self.check_horizontal
    self.check_vertical
    self.check_diagonal_down
    self.check_diagonal_up
  end

  def play_game
    while @game_on
      self.draw_board
      self.white_move
      self.check_state
      if !@game_on
        puts "#{@winner} has won the game."
        self.draw_board
        break
      end
      self.draw_board
      self.black_move
      self.check_state
      if !@game_on
        puts "#{@winner} has won the game."
        self.draw_board
        break
      end
    end
  end
  

end

class Space

  attr_accessor :value,
  
  def initialize
    @value = nil
  end

  def value
    @value
  end

  def set_white
    @value = "white"
  end

  def set_black
    @value = "black"
  end

  def draw_space
    case @value
    when nil 
      return "  "
    when "white" 
      return "⚫"
    when "black" 
      return "⚪"
    end
  end

end

# board = Board.new
# board.play_game


  
