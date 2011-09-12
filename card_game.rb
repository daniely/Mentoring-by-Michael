class CardGame
  attr_accessor :cards

  def initialize(decks=1)
    self.cards = []

    decks.times do
      %w(A 2 3 4 5 6 7 8 9 T J Q K).each do |rank|
        %w(c s d h).each do |suit|
          cards << rank + suit
        end
      end
    end
  end
end
