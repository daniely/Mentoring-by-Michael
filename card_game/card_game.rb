require 'ruby-debug'

class CardGame
  attr_accessor :cards, :players, :decks
  CARDS_PER_DECK = 52

  def initialize(decks=1)
    self.decks = decks
  end

  def deal(num_players=1, cards_each=5)
    reset_game
    deal_cards_to_players(num_players, cards_each)
  end

  def display
    puts self.to_s
  end

  def to_s
    text = []
    self.players.each { |player| text << "#{player}" }
    text << "Cards used: #{cards_used}"
    text << "Cards remaining: #{cards_remaining}"
    return text.join("\n")
  end

  def cards_used
    (self.decks * CARDS_PER_DECK) - cards_remaining
  end

  def cards_remaining
    self.cards.count
  end

  private

  def reset_game
    self.players = []
    self.cards = shuffled_deck(self.decks)
  end

  def deal_cards_to_players(num_players, cards_each)
    num_players.times do |n|
      self.players << Player.new( n, self.cards.pop(cards_each) )
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
  attr_accessor :name, :cards

  def initialize(num, cards)
    self.name = name_player(num)
    self.cards = cards
  end

  def to_s
    "#{self.name}: #{self.cards.join(' | ')}"
  end

  private

  def name_player(num)
    "Player #{num.next}"
  end
end
