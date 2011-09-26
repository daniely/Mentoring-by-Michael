require './card_game'

describe CardGame do
  before do
    # keep results consistent
    srand(1)
  end

  let(:game1) { CardGame.new }
  let(:game2) { CardGame.new(2) }

  describe ".new" do
    it 'create new game' do
      game1.should be
    end

    it 'defaults to 1 deck' do
      game1.decks.should == 1
    end

    it 'creates deck of cards' do
      game1.cards.count.should == 52
      game1.cards.include?('5s').should == true
    end
  end

  describe ".new(decks)" do
    it 'create new game with specified decks' do
      game2.decks.should == 2
    end

    it 'creates deck(s) of cards' do
      game2.cards.count.should == 52 * 2
    end
  end

  describe "#deal" do
    it 'default to 1 player' do
      game1.deal
      game1.players.size.should == 1
    end

    it 'default to 5 cards per player' do
      game1.deal
      game1.players.first.size.should == 5
    end

    it 'deals valid cards' do
      game1.deal
      game1.players.first.first.size.should == 2
    end
  end

  describe "#deal(4)" do
    it 'deals cards to 4 players' do
      game1.deal(4)
      game1.players.size.should == 4
    end
  end

  describe "#display (default)" do
    it 'default to showing 1 players cards' do
      results = <<eos
Player 1: Th | Ah | Tc | Qd | Js
Cards used: 5
Cards remaining: 47
eos
      game1.deal
      $stdout.should_receive(:puts).with(results.chomp)
      game1.display
    end
  end

  describe "#display after #deal(4)" do
    it 'shows cards of 4 players' do
       results = <<eos
Player 1: Th | Ah | Tc | Qd | Js
Player 2: 6h | 2c | 5s | Kc | Ac
Player 3: 7d | 4c | 9s | 8d | Qs
Player 4: 6d | 3s | 5h | 4d | Jd
Cards used: 20
Cards remaining: 32
eos
      game1.deal(4)
      $stdout.should_receive(:puts).with(results.chomp)
      game1.display
    end

    it 'shows cards of 6 players with 10 cards each' do
      results = <<eos
Player 1: Qs | 4h | 5c | Ad | 8h | As | 7d | As | 4h | 9h
Player 2: 9c | Ks | 7c | Qs | 3d | 4d | 7c | 3s | Qd | 3s
Player 3: 2d | Qh | Kc | 6c | Jc | Tc | Kd | Kh | Kh | Qd
Player 4: 8d | Th | Ac | 7h | Qc | Td | 6c | 9s | 7h | 2s
Player 5: 5d | 9s | 4s | 3h | 9c | 4d | Jh | 8c | Js | 8h
Player 6: 5s | 4c | Tc | Ad | 7s | 9d | Th | 2h | 8d | 8s
Cards used: 60
Cards remaining: 44
eos
      game2.deal(6, 10)
      $stdout.should_receive(:puts).with(results.chomp)
      game2.display
    end
  end
end
