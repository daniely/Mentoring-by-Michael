require 'ruby-debug'

class CardGame
  attr_accessor :cards, :players

  def initialize(decks=1)
    @decks = decks
    @cards = new_deck(@decks)
    @players = []

  end

  def deal(num_players=1)
    @cards = new_deck(@decks)
    @players = []

    num_players.times do |n|
      player_cards = []
      5.times { player_cards << @cards.pop }
      @players << Player.new(player_cards)
    end
  end

  private

  def new_deck(decks)
    cards = []
    decks.times do
      %w(A 2 3 4 5 6 7 8 9 T J Q K).each do |rank|
        %w(c s d h).each do |suit|
          cards << rank + suit
        end
      end
    end
    return cards.shuffle!
  end
end

class Player
  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end
end
