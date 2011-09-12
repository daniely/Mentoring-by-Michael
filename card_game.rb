class CardGame
  attr_accessor :cards

  def initialize(decks=1)
    self.cards = []
    (52 * decks).times do
      cards << 1
    end
  end
end
