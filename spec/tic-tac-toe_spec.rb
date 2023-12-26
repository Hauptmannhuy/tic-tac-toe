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

end