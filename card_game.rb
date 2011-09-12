require 'ruby-debug'

class CardGame
  attr_accessor :cards, :players

  def initialize(decks=1)
    @cards = []
    @players = []

    decks.times do
      %w(A 2 3 4 5 6 7 8 9 T J Q K).each do |rank|
        %w(c s d h).each do |suit|
          @cards << rank + suit
        end
      end
    end
  end

  def deal
    player_cards = []
    5.times { player_cards << @cards.shuffle!.pop }
    @players << Player.new(player_cards)
  end
end

class Player
  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end
end
