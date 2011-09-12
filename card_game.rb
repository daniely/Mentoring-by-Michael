class CardGame
  attr_accessor :cards

  def initialize
    self.cards = []
    52.times do
      cards << 1
    end
  end
end

describe CardGame do
  describe "#new" do
    it 'creates number of decks based on optional parameter' do
      game1 = CardGame.new
      game1.cards.count.should == 52
    end
  end
end
