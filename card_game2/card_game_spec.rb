require './card_game'

describe CardGame do
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

  describe "#display" do
    it 'default to showing 1 players cards' do
      game1.deal
      game1.display
    end
  end

  describe "#display after #deal(4)" do
    it 'shows cards of 4 players' do
      game1.deal(4)
      game1.display

      game2.deal(6, 10)
      game2.display
    end
  end
end
