class Game
  attr_accessor :players, :p1, :p2

  def initialize
    @taken_numbers = []
    @players = []
    @numbers = { 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9 }
    @move_status = false
    
  end

  def self.start
    puts "Welcome to the tic-tac-toe!\nPress any button if you wish start a new game!"
    new_game = Game.new
    new_game.set_players
    new_game.play
  end

  def set_players
    @p1 = choose_name
    @p1_marker = choose_marker
    @players << @p1
    @p2 = choose_name
    @p2_marker = choose_marker
    @players << @p2
  end

  def display_board
    puts " #{@numbers[1]}  | #{@numbers[2]}  | #{@numbers[3]}  "
    puts ' ---+---+---'
    puts " #{@numbers[4]}  | #{@numbers[5]}  | #{@numbers[6]}  "
    puts ' ---+---+---'
    puts " #{@numbers[7]}  | #{@numbers[8]}  | #{@numbers[9]}  "
  end

  def play
    loop do
      display_board
      player_move
      break if is_draw? || check_win

      switch_player
    end
    display_board
    game_restart
  end

  def choose_name
    puts "What is the name of player #{@players.any? ? '2' : '1'}?"
    input_name = gets.chomp
    if @players.any? && input_name == @players[0]
      while input_name == @players[0]
        puts "Your name shouldn't be #{@players[0]}"
        input_name = gets.chomp
      end
    end
    input_name
  end

  def choose_marker
    puts 'What game marker would you like to use? (Select 1 letter or special character)'
    input_marker = gets.chomp
    while input_marker.length != 1 || input_marker == @p1_marker
      if input_marker.length != 1
        puts 'Your mark should be exactly one character'
      else
        puts "Your marker shouldn't be #{input_marker}. Please choose another marker."
      end
      input_marker = gets.chomp
    end
    input_marker
  end

  def player_move
    puts "Player:#{@move_status == false ? @p1 : @p2} should make his move"
    input = gets.chomp.to_i
    while @taken_numbers.include?(input) || !(1..9).include?(input)
      if @taken_numbers.include?(input)
        puts 'This number has already taken!'
      else
        puts 'Input should only be 1-9 digit!'
      end
      input = gets.chomp.to_i
    end
    @taken_numbers << input
    change_board(input)
  end

  def change_board(input)
    @numbers[input] = @move_status == false ? @p1_marker : @p2_marker
  end

  def switch_player
    @move_status = @move_status == false
  end

  def check_win
    win_comb =
      [1, 2, 3], # top_row
      [4, 5, 6], # middle_row
      [7, 8, 9], # bottom_row
      [1, 4, 7], # left_column
      [2, 5, 8], # center_column
      [3, 6, 9], # right_column
      [1, 5, 9], # left_diagonal
      [3, 5, 7] # right_diagonal
    win_comb.each do |combination|
      position_1 = combination[0]
      position_2 = combination[1]
      position_3 = combination[2]
      marker = @move_status == false ? @p1_marker : @p2_marker
      if @numbers[position_1] == marker && @numbers[position_2] == marker && @numbers[position_3] == marker
        puts "Player #{@move_status == false ? @p1 : @p2} wins!"
        return true
      end
    end
    false
  end

  def is_draw?
    return unless @numbers.all? { |_key, value| value.is_a? String } && !check_win

    puts "It's a draw!"
    true
  end

  def game_restart
    puts "Would you like to start a new game? Type 'Y' if so"
    input = gets.chomp.downcase
    input == 'y' ? Game.start : 'Thanks for playing!'
  end
end

Game.start
