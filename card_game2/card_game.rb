require 'ruby-debug'

class CardGame
  attr_accessor :decks, :players, :cards

  def initialize(decks=1)
    @decks = decks
    @cards = shuffled_decks(decks)
  end

  def deal(num_players=1, cards_each=5)
    @players = []
    num_players.times do
      self.players << self.cards.shift(cards_each)
    end
  end

  def display
    text = []
    self.players.each_with_index do |p, i|
      text << "Player #{i.next}: " + p.join(' | ')
    end
    text << "Cards used: #{self.players.flatten.count}"
    text << "Cards remaining: #{self.cards.count}"
    puts text.join("\n")
  end

  private

  def shuffled_decks(decks)
    suit = %w(h s d c)
    rank = *(2..9).to_a + %w(T J Q K A)
    cards = rank.product(suit).map{|c| c.join}
    (cards * decks).shuffle
  end
end
