require './card_game'

describe CardGame do
  describe "#new" do
    let(:game1) { CardGame.new }

    it 'is valid' do
      game1.should be
    end

    it 'created a deck of cards' do
      game1.cards.count.should == 52
    end

    it 'contains cards like Ac, Ts' do
      game1.cards.should include('Ac')
      game1.cards.should include('Ts')
    end

    context 'with optional parameter of 2' do
      let(:game2) { CardGame.new(2) }
      it 'creates 2 decks of cards' do
        game2.cards.count.should == 52 * 2
      end
    end
  end
end
