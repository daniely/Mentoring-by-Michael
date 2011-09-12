require './card_game'

describe CardGame do
  let(:game1) { CardGame.new }
  let(:game2) { CardGame.new(2) }

  describe "#new" do

    it 'is valid' do
      game1.should be
    end

    it 'creates a deck of cards' do
      game1.cards.count.should == 52
    end

    it 'contains cards like Ac, Ts' do
      game1.cards.should include('Ac')
      game1.cards.should include('Ts')
    end

    context 'with optional parameter of 2' do
      it 'creates 2 decks of cards' do
        game2.cards.count.should == 52 * 2
      end
    end
  end

  describe "#deal" do
    before(:all) do
      game1.deal
    end

    it 'involves 1 player' do
      game1.players.count.should == 1
    end

    it 'lowers count of cards' do
      game1.cards.count.should == 52 - 5
    end

    it 'removes played cards from deck' do
      player_cards = game1.players.first.cards
      game1.cards.should_not include(player_cards)
    end

    it 'assigns cards to player' do
      game1.players.first.class.should == Player
    end

    it 'assigns cards randomly' do
      pending "dunno how to test this"
    end
  end
end
