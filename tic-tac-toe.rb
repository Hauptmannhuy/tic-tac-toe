class Game
  @@move_status = false
  @@numbers = {1 =>1, 2 => 2, 3 =>3, 4 =>4, 5 =>5, 6 =>6, 7 =>7, 8 =>8, 9 =>9}
  
  def self.move_status
    @@move_status
  end
  def self.move_switch
    @@move_status = Game.move_status == false ? true : false
  end
  def self.numbers
    @@numbers
  end
  
  def self.show_board 
    "
  #{Game.numbers[1]} | #{Game.numbers[2]} | #{Game.numbers[3]}
 ---+---+---
  #{Game.numbers[4]} | #{Game.numbers[5]} | #{Game.numbers[6]}
 ---+---+---
  #{Game.numbers[7]} | #{Game.numbers[8]} | #{Game.numbers[9]}
 ---+---+--- 
  " 
end
  
def self.player_move
    puts "Make your move, #{@@move_status == false ? Player.players[0].name : Player.players[1].name}!"
     input = gets.chomp.to_i
    self.change_board(input)
end

def self.change_board(input)
  Game.numbers[input] = Game.move_status == false ? Player.players[0].marker : Player.players[1].marker
  Game.move_switch
  puts Game.show_board
end
  def self.check_win
    if (Game.numbers[1] == Game.numbers[2] && Game.numbers[2] == Game.numbers[3]) ||
        (Game.numbers[4] == Game.numbers[5] && Game.numbers[5] == Game.numbers[6]) ||
        (Game.numbers[7] == Game.numbers[8] && Game.numbers[8] == Game.numbers[9]) ||
        (Game.numbers[1] == Game.numbers[4] && Game.numbers[4] == Game.numbers[7]) ||
        (Game.numbers[2] == Game.numbers[5] && Game.numbers[5] == Game.numbers[8]) ||
        (Game.numbers[3] == Game.numbers[6] && Game.numbers[6] == Game.numbers[9]) ||
        (Game.numbers[1] == Game.numbers[5] && Game.numbers[5] == Game.numbers[9]) ||
        (Game.numbers[3] == Game.numbers[5] && Game.numbers[5] == Game.numbers[7])
      return true
    else
      return false
    end
end

class Player
  @@player_count = 1
  @@players = []
  attr_reader :name, :marker
  def initialize(name, marker)
    @name = name
    @marker = marker
    @@players << self
    @@player_count+=1
  end
  def Player.choose_name_marker

    puts "What is the name of player #{@@player_count}?"
    input_name = gets.chomp
    if @@players.any? && input_name == Player.players[0].name
      while input_name == Player.players[0].name do
      puts "Your name shouldn't be #{Player.players[0].name}"
      input_name = gets.chomp
      end
    end

    puts 'What game marker would you like to use? (Select 1 letter or special character)'
    input_marker = gets.chomp
    while input_marker.length != 1 || players.any? {|player| player.marker == input_marker}
      if input_marker.length != 1 
        puts "Your mark should be exactly one character"
      else
        puts "Your marker shouldn't be #{input_marker}. Please choose another marker."
    end
    input_marker = gets.chomp
  end
    
    Player.new(input_name,input_marker)
end

def self.players
    return @@players
  end
end

p1 = Player.choose_name_marker
p2 = Player.choose_name_marker
puts Game.show_board

while Game.check_win != true do
  Game.player_move
end
  puts "Player #{@@move_status == false ? Player.players[1].name: Player.players[0].name} wins! Game over."
end
