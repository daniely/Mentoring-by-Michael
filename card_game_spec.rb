require './card_game'

describe CardGame do
  let(:game1) { CardGame.new }
  let(:game2) { CardGame.new(2) }

  describe "#new" do

    it 'is valid' do
      game1.should be
    end

    it 'creates a deck of cards' do
      game1.cards.count.should == 52
    end

    it 'contains cards like Ac, Ts' do
      game1.cards.should include('Ac')
      game1.cards.should include('Ts')
    end

    context 'with optional parameter of 2' do
      it 'creates 2 decks of cards' do
        game2.cards.count.should == 52 * 2
      end
    end
  end

  describe "#deal" do
    before(:all) do
      game1.deal
    end

    it 'names player "Player 1"' do
      game1.players.first.name.should == 'Player 1'
    end

    it 'involves 1 player' do
      game1.players.count.should == 1
    end

    it 'lowers count of cards' do
      game1.cards.count.should == 52 - 5
    end

    it 'removes played cards from deck' do
      player_cards = game1.players.first.cards
      game1.cards.should_not include(player_cards)
    end

    it 'assigns cards to player' do
      game1.players.first.class.should == Player
    end

    it 'resets players cards for each deal' do
      old_players_cards = game1.players.first.cards
      game1.deal
      game1.players.first.cards.should_not == old_players_cards
    end

    it 'assigns cards randomly' do
      pending "dunno how to test this"
    end

    context "with 4 players" do
      before(:all) do
        game1.deal(4)
      end

      it 'names each player correctly (Player 1, Player2, etc)' do
        game1.players[0].name.should == 'Player 1'
        game1.players[1].name.should == 'Player 2'
        game1.players[2].name.should == 'Player 3'
        game1.players[3].name.should == 'Player 4'
      end

      it 'deals cards for 4 players' do
        game1.players.count.should == 4
      end

      it 'removes 20 cards from deck (5 cards each for 4 players = 20)' do
        game1.cards.count.should == 32
      end
    end

    context "with 4 players and 10 cards per deal" do
      before(:all) do
        game1.deal(4, 10)
      end

      it 'deals 10 cards per player' do
        game1.players.each do |player|
          player.cards.count.should == 10
        end
      end

      it 'removes 40 cards from the deck' do
        game1.cards.count.should == 52 - 40
      end

      it 'deals to 4 players' do
        game1.players.count.should == 4
      end
    end
  end

  describe "#cards_used" do
    it 'counts number of cards used' do
      game1.deal(4, 10)
      game1.cards_used.should == 4 * 10
    end
  end

  describe "#cards_remaining" do
    it 'counts number of cards remaining in deck' do
      game1.deal(4, 10)
      game1.cards_remaining.should == 52 - 40
    end
  end

  describe "#display" do
    it 'shows current state of game' do
      game1.deal(4, 5)
      game1.display
    end
  end
end

describe Player do
  it 'is valid' do
    Player.new(0, 'cards').should be
  end

  describe "#to_s" do
    it 'shows nicely formatted player info' do
      player = Player.new(0, %w(Ac 2d Ts 4h Ks))
      player.to_s.should == "Player 1: Ac | 2d | Ts | 4h | Ks"
    end
  end
end
