require_relative '../lib/tic_tac_toe.rb'

describe Game do

  describe "#choose_name" do

    subject(:game_name){ described_class.new }

    context "When no player is specifed" do  
      before do
        allow(game_name).to receive(:puts)
        allow(game_name.instance_variable_get(:@players)).to receive(:any?).and_return(false)
        allow(game_name).to receive(:gets).and_return('Player1')
     
      end
      it "returns message asking the name of first player" do
        expect(game_name).to receive(:puts).with("What is the name of player 1?")
        game_name.choose_name
      end
      it "returns input of first player's name" do
        expect(game_name.choose_name).to eq('Player1')
      end
    end
    
    context "When first player name already specified" do
      before do
        allow(game_name).to receive(:puts)
        allow(game_name.instance_variable_get(:@players)).to receive(:any?).and_return(true)
        game_name.instance_variable_get(:@players) << 'Player1'
        allow(game_name).to receive(:gets).and_return('Player1','Player2')
        
      end
      
      it "returns message asking the name of second player" do
        expect(game_name).to receive(:puts).with("What is the name of player 2?")
        game_name.choose_name
      end

      it "throws message when trying to input name that already exists" do
        expect(game_name).to receive(:puts).with("Your name shouldn't be Player1").once
        game_name.choose_name
      end
    end
  end

  describe "#choose_marker" do
    subject(:game_marker){ described_class.new() }
    
    context "When input is valid" do
      before do
        allow(game_marker).to receive(:gets).and_return('X')
      end
      it 'returns input' do
        expect(game_marker.choose_marker).to eq('X')
        game_marker.choose_marker
      end
    end
    
    context "When user inputs an incorrect value once and then valid value" do
      before do
        allow(game_marker).to receive(:puts)
        allow(game_marker).to receive(:gets).and_return('Xx','X')
      end
      it 'completes loop and displays error message once' do
        error_message = "Input error! Input should be exactly 1 character and shouldn't repeat first player's marker."
        expect(game_marker).to receive(:puts).with(error_message).once
        game_marker.choose_marker
      end
    end
    context "When user trying to input marker that already exists and valid value" do
      before do
        allow(game_marker).to receive(:puts)
        game_marker.instance_variable_set(:@p1_marker,'X') 
        allow(game_marker).to receive(:gets).and_return('X','Y')
      end
      it "completes loop and displays error message once" do
        error_message = "Input error! Input should be exactly 1 character and shouldn't repeat first player's marker."
        expect(game_marker).to receive(:puts).with(error_message).once
        game_marker.choose_marker
      end
    end
  end

  describe "#player_move" do
    subject(:game_move){ described_class.new() }

    context 'When move status is false' do
      before do
        game_move.instance_variable_set(:@p1, 'Danya')
        game_move.instance_variable_set(:@p2, 'Dasha')
       game_move.instance_variable_set(:@move_status, false)
      end
      it "informs that it is the first player turn" do
        allow(game_move).to receive(:gets).and_return("1\n")
         expect(game_move).to receive(:puts).with("Player:#{game_move.instance_variable_get(:@p1)} should make his move").once
         game_move.player_move
      end
    end

    context "When user inputs an incorrect value once, then a valid input" do

      before do
        allow(game_move).to receive(:puts)
        game_move.instance_variable_get(:@taken_numbers) << 1
        allow(game_move).to receive(:gets).and_return("1\n","2\n")
      end
      it 'throws an error message' do
        error_message = "This number has already taken!"
        expect(game_move).to receive(:puts).with(error_message).once
        game_move.player_move
      end
      it 'sends an message to #change_board method' do
        expect(game_move).to receive(:change_board)
        game_move.player_move
      end
    end
    context "When user inputs correct value" do

      before do
        allow(game_move).to receive(:puts)
        allow(game_move).to receive(:gets).and_return("1\n")
      end
      it 'changes "@taken numbers" variable by 1' do
      expect{ game_move.player_move }.to change{game_move.instance_variable_get(:@taken_numbers).length}.by(1)
      end
      it 'sends message to "change board" method' do
        expect(game_move).to receive(:change_board)
        game_move.player_move
      end
    end
  end

    describe "#check_win" do
      subject(:game_win){ described_class.new() }
      context "When input matches with win combination" do

        before do
          game_win.instance_variable_set(:@p1_marker, 'X')
        end

        it 'returns true if win combination is [1,2,3]' do
          nums = { 1 => 'X', 2 => 'X', 3 => 'X', 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9 }
          game_win.instance_variable_set(:@numbers, nums)
          expect(game_win.check_win).to eq(true)
        end

        it 'returns true if win combination is [4,5,6]' do
        nums = { 1 => 'X', 2 => 'X', 3 => 'Y', 4 => 'X', 5 => 'X', 6 => 'X', 7 => 7, 8 => 8, 9 => 9 }
        game_win.instance_variable_set(:@numbers, nums)
        expect(game_win.check_win).to eq(true)
        end
      end

      context "When input doesn't match" do
        
        before do
          game_win.instance_variable_set(:@p1_marker, 'X')
         
        end
        it 'returns false' do
          nums = { 1 => 'X', 2 => 'Y', 3 => 'X', 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9 }
          game_win.instance_variable_set(:@numbers, nums)
          expect(game_win.check_win).to eq(false)
        end
      end
    end

    describe "#is_draw?" do
      subject(:game_draw){ described_class.new() }

      context "When every cell is covered by marker but no win combination" do
        before do
          nums = { 1 => 'X', 2 => 'Y', 3 => 'X', 4 => 'Y', 5 => 'X', 6 => 'Y', 7 => 'Y', 8 => 'X', 9 => 'Y' }
          game_draw.instance_variable_set(:@numbers, nums)
          allow(game_draw).to receive(:check_win).and_return(false)

        end
        it 'returns true' do
        expect(game_draw.is_draw?).to eq(true)
        end
      end

      context "When all cells aren't filled with markers" do
        before do
          nums = { 1 => 'X', 2 => 'Y', 3 => 'X', 4 => 'Y', 5 => 'X', 6 => 'Y', 7 => 'Y', 8 => 'X', 9 => 9 }
          game_draw.instance_variable_set(:@numbers, nums)
          allow(game_draw).to receive(:check_win).and_return(false)
        end
        it 'returns nil' do
          expect(game_draw.is_draw?).to eq(nil)
        end
      end
    end
    
    describe "#change_board" do
      subject(:game_board){ described_class.new() }
      context "When it's first player and '1' is given input" do
        before do
         
          game_board.instance_variable_set(:@p1_marker, 'X')
        end
        it "changes first square to 'X'" do
          num = game_board.instance_variable_get(:@numbers)
          expect { game_board.change_board(1) }.to change {num[1]}.from(1).to('X')
          
        end
        it "changes ninth square to 'X'" do
          num = game_board.instance_variable_get(:@numbers)
          expect { game_board.change_board(9) }.to change {num[9]}.from(9).to('X')
        end
      end
    end

end