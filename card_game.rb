class CardGame
  attr_accessor :cards

  def initialize
    self.cards = []
    52.times do
      cards << 1
    end
  end
end
