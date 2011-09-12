require './card_game'

game1 = CardGame.new
game1.deal
game1.display
puts
game1.deal(4)
game1.display
puts
game2 = CardGame.new(2)
game2.deal(6,10)
game2.display
