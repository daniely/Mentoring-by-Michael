require 'ruby-debug'

class CardGame
  attr_accessor :cards, :players

  def initialize(decks=1)
    @decks = decks
    @cards = new_deck(@decks)
    @players = []

  end

  def deal(num_players=1, cards_each=5)
    initialize
    deal_cards_to_players(num_players, cards_each)
  end

  private

  def deal_cards_to_players(num_players, cards_each)
    num_players.times do |n|
      player_cards = deal_cards(cards_each)
      @players << Player.new(n,  player_cards)
    end
  end

  def deal_cards(num)
    cards = []
    num.times { cards << @cards.pop }
    return cards
  end

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
  attr_accessor :name
  attr_accessor :cards

  def initialize(num, cards)
    @name = name_player(num)
    @cards = cards
  end

  private

  def name_player(num)
    'Player ' + (num + 1).to_s
  end
end
