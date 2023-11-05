class Game
  attr_accessor :players, :p1,:p2
def initialize
 @players = []
end

def self.start
 puts 'Welcome to the tic-tac-toe! \n Press any button if you wish start a new game!'
 new_game = Game.new
 gets
  new_game.init_players


end

def init_players
@p1 = choose_name
# @p1_marer = 
@players << @p1
@p2 = choose_name
# @p2_marker = 
@players << @p2

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
  while input_marker.length != 1 || @players.any? {|player| player.marker == input_marker}
    if input_marker.length != 1 
      puts "Your mark should be exactly one character"
    else
      puts "Your marker shouldn't be #{input_marker}. Please choose another marker."
  end
  input_marker = gets.chomp
end
  
end


end

Game.start

