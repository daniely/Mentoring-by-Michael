require 'ruby-debug'

class CardGame
  attr_accessor :cards, :players, :decks
  CARDS_PER_DECK = 52

  def initialize(decks=1)
    @decks = decks
    @cards = shuffled_deck(@decks)
    @players = []
  end

  def deal(num_players=1, cards_each=5)
    initialize(@decks)
    deal_cards_to_players(num_players, cards_each)
  end

  def display
    @players.each { |player| puts player }
    puts "Cards used: #{cards_used}"
    puts "Cards remaining: #{cards_remaining}"
  end

  def cards_used
    (@decks * CARDS_PER_DECK) - cards_remaining
  end

  def cards_remaining
    @cards.count
  end

  private

  def deal_cards_to_players(num_players, cards_each)
    num_players.times do |n|
      @players << Player.new( n, @cards.pop(cards_each) )
    end
  end

  def shuffled_deck(decks)
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

  def to_s
    text = @name + ':'
    @cards.each do |c|
      text += " #{c} |"
    end
    text.chomp(' |')
  end

  private

  def name_player(num)
    'Player ' + (num + 1).to_s
  end
end
