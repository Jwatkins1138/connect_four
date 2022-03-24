require '../lib/connect_four.rb'

describe Board do

  describe "#check_input" do
    subject(:check_board) { described_class.new}
    
    context "when input is valid" do
      it "returns true" do
        
        value_check = check_board.check_input(5)
        expect(value_check).to be(true)
      end
    end

    context "when input is invalid do to non-existence" do
      it "returns false when number is too high" do
        value_check = check_board.check_input(8)
        expect(value_check).to be(false)
      end
      it "returns false when input is not a number" do
        value_check = check_board.check_input("five")
        expect(value_check).to be(false)
      end
    end

    context "when input is invalid do to column being full" do
    
      
      it "returns false when row is full" do
        check_board.set_black(0, 0)
        value_check = check_board.check_input(0)
        expect(value_check).to be(false)
      end

      it "returns true if column has some spaces occupied but not all/top" do
        check_board.set_black(5, 0)
        check_board.set_black(4, 0)
        check_board.set_black(3, 0)
        check_board.set_black(2, 0)
        check_board.set_black(1, 0)
        value_check = check_board.check_input(0)
        expect(value_check).to eq(true)
      end
    end
  end
  describe "#set_white and #set_black" do
    subject(:set_board) { described_class.new }
    context "when not set" do
      it "returns value of nil" do
        nil_space = set_board.space(1, 0)
        expect(nil_space.value).to eq(nil)
      end
    end

    context "when set to white" do
      it "returns value of 'white'" do
        set_board.set_white(1, 0)
        white_space = set_board.space(1, 0)
        expect(white_space.value).to eq("white")
      end
    end

    context "when set to black" do
      it "returns value of 'black'" do
        set_board.set_black(1, 0)
        black_space = set_board.space(1, 0)
        expect(black_space.value).to eq("black")
      end
    end
  end
  describe "#check_horizontal" do
    subject(:horizontal_board) { described_class.new }
    context "when there is no horizontal match" do
      it "does not change game state when no spaces are occupied" do
        
        horizontal_board.check_horizontal
        state_check = horizontal_board.game_state
        expect(state_check).to eq(true)
      end

      it "does not change game state when some spaces are occupied" do
        
        horizontal_board.set_black(1, 2)
        horizontal_board.set_white(1, 3)
        horizontal_board.set_black(1, 4)
        horizontal_board.set_white(1, 5)
        horizontal_board.check_horizontal
        state_check = horizontal_board.game_state
        expect(state_check).to eq(true)
      end
    end
    context "when there is a horizontal match" do
      it "does change the game state" do
        horizontal_board.set_black(1, 2)
        horizontal_board.set_black(1, 3)
        horizontal_board.set_black(1, 4)
        horizontal_board.set_black(1, 5)
        horizontal_board.check_horizontal
        state_check = horizontal_board.game_state
        expect(state_check).to eq(false)
      end

      it "does change the game state at edge" do
        horizontal_board.set_black(1, 3)
        horizontal_board.set_black(1, 4)
        horizontal_board.set_black(1, 5)
        horizontal_board.set_black(1, 6)
        horizontal_board.check_horizontal
        state_check = horizontal_board.game_state
        expect(state_check).to eq(false)
      end

      it "does update the winner" do
        horizontal_board.set_black(1, 3)
        horizontal_board.set_black(1, 4)
        horizontal_board.set_black(1, 5)
        horizontal_board.set_black(1, 6)
        horizontal_board.check_horizontal
        win_check = horizontal_board.winner
        expect(win_check).to eq("black")
      end
    end
  end

  describe "#check_vertical" do
    subject(:vertical_board) { described_class.new }
    context "when there is no vertical match" do
      it "does not change game state when no spaces are occupied" do
        
        vertical_board.check_vertical
        state_check = vertical_board.game_state
        expect(state_check).to eq(true)
      end

      it "does not change game state when some spaces are occupied" do
        
        vertical_board.set_black(2, 1)
        vertical_board.set_white(3, 1)
        vertical_board.set_black(4, 1)
        vertical_board.set_white(5, 1)
        vertical_board.check_vertical
        state_check = vertical_board.game_state
        expect(state_check).to eq(true)
      end
    end
    context "when there is a vertical match" do
      it "does change the game state" do
        vertical_board.set_black(1, 1)
        vertical_board.set_black(2, 1)
        vertical_board.set_black(3, 1)
        vertical_board.set_black(4, 1)
        vertical_board.check_vertical
        state_check = vertical_board.game_state
        expect(state_check).to eq(false)
      end

      it "does change the game state at edge" do
        vertical_board.set_black(2, 1)
        vertical_board.set_black(3, 1)
        vertical_board.set_black(4, 1)
        vertical_board.set_black(5, 1)
        vertical_board.check_vertical
        state_check = vertical_board.game_state
        expect(state_check).to eq(false)
      end

      it "does update the winner" do
        vertical_board.set_white(2, 1)
        vertical_board.set_white(3, 1)
        vertical_board.set_white(4, 1)
        vertical_board.set_white(5, 1)
        vertical_board.check_vertical
        win_check = vertical_board.winner
        expect(win_check).to eq("white")
      end
    end
  end

  describe "#check_diagonal_down" do
    subject(:diagonal_down_board) { described_class.new }
    context "when there is no downward dia match" do
      it "does not change game state when no spaces are occupied" do
        
        diagonal_down_board.check_diagonal_down
        state_check = diagonal_down_board.game_state
        expect(state_check).to eq(true)
      end
    end

    context "when there is a donward dia match" do
      it "does change the game state" do
        diagonal_down_board.set_black(2, 0)
        diagonal_down_board.set_black(3, 1)
        diagonal_down_board.set_black(4, 2)
        diagonal_down_board.set_black(5, 3)
        diagonal_down_board.check_diagonal_down
        state_check = diagonal_down_board.game_state
        expect(state_check).to eq(false)
      end
    end
  end

  describe "#check_diagonal_up" do
    subject(:diagonal_up_board) { described_class.new }
    context "when there is no upward dia match" do
      it "does not change game state when no spaces are occupied" do
        
        diagonal_up_board.check_diagonal_up
        state_check = diagonal_up_board.game_state
        expect(state_check).to eq(true)
      end
    end

    context "when there is a upward dia match" do
      it "does change the game state" do
        diagonal_up_board.set_black(5, 3)
        diagonal_up_board.set_black(4, 4)
        diagonal_up_board.set_black(3, 5)
        diagonal_up_board.set_black(2, 6)
        diagonal_up_board.check_diagonal_up
        state_check = diagonal_up_board.game_state
        expect(state_check).to eq(false)
      end
    end
  end

  describe "#check_state" do
    subject(:diagonal_up_board) { described_class.new }
    context "when there is no upward dia match" do
      it "does not change game state when no spaces are occupied" do
        
        diagonal_up_board.check_state
        state_check = diagonal_up_board.game_state
        expect(state_check).to eq(true)
      end
    end

    context "when there is a upward dia match" do
      it "does change the game state" do
        diagonal_up_board.set_black(5, 3)
        diagonal_up_board.set_black(4, 4)
        diagonal_up_board.set_black(3, 5)
        diagonal_up_board.set_black(2, 6)
        diagonal_up_board.check_state
        state_check = diagonal_up_board.game_state
        expect(state_check).to eq(false)
      end
    end
  end
end
    