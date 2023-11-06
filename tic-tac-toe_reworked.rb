class Game
  attr_accessor :players, :p1,:p2
def initialize
 @players = []
 @numbers = {1=>1, 2=>2, 3=>3, 4=>4, 5=>5, 6=>6, 7=>7, 8=>8, 9=>9}
 
end

def self.start
  puts "Welcome to the tic-tac-toe!\nPress any button if you wish start a new game!"
  new_game = Game.new
  gets
  new_game.init_players


end

def init_players
  @p1 = choose_name
  @p1_marker = choose_marker
  @players << @p1
  @p2 = choose_name
  @p2_marker = choose_marker
  @players << @p2
  @move_status = false
  player_move
end

def choose_name
  puts "What is the name of player #{@players.any? ? '2' : '1'}?"
  input_name = gets.chomp
  if @players.any? && input_name == @players[0]
    while input_name == @players[0] do
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
      puts "Your mark should be exactly one character"
    else
      puts "Your marker shouldn't be #{input_marker}. Please choose another marker."
  end
  input_marker = gets.chomp
end
  input_marker
end

def player_move
  taken_numbers = []
  unless check_win do
    display_board
    puts "Player:#{@move_status == false ? @p1 : @p2} should make his move"
    input = gets.chomp.to_i
    while taken_numbers.include?(input)
      puts 'This number has already taken!'
      input = gets.chomp.to_i
    end
    taken_numbers << input
    change_board(input)
  end
end

def change_board(input)
    @numbers[input] = @move_status == false ? @p1_marker : @p2_marker
    @move_status = @move_status == false ? true : false
end

def check_win
  
end

def display_board
  puts " #{@numbers[1]}  | #{@numbers[2]}  | #{@numbers[3]}  "
  puts " ---+---+---"
  puts " #{@numbers[4]}  | #{@numbers[5]}  | #{@numbers[6]}  "
  puts " ---+---+---"
  puts " #{@numbers[7]}  | #{@numbers[8]}  | #{@numbers[9]}  "
end

end

Game.start
