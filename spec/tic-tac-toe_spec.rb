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
    
  end

end