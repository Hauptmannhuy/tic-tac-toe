class Game
  @@board =' 
  1 | 2 | 3
 ---+---+---
  3 | 4 | 5
 ---+---+---
  6 | 7 | 9
 ---+---+--- 
 '
  def self.show_board 
    @@board
  end
end

class Player
  @@players = 1
  attr_reader :name, :marker
  def initialize(name, marker)
    @name = name
    @marker = marker
    @@players+=1
  end
  def Player.choose_name_marker
    puts "What is the name of player #{@@players}?"
    input_name = gets.chomp
    puts 'What game marker would you like to use? (Select 1 letter or special character)'
    input_marker = gets.chomp
    if input_marker.length != 1 
      while input_marker.length != 1 do
        puts 'Wrong input, please, try again'
        input_marker = gets.chomp
        
      end
    end
    Player.new(input_name,input_marker)
end
end
puts p1 = Player.choose_name_marker
puts p2 = Player.choose_name_marker


