require 'rspec'
require 'Game'

describe Game do 
	subject(:game) { Game.new }
	let(:deck) {double("deck")}
	let(:card) { double("card", :type => 'K', :symbol => '♥') }

	describe '#initialize' do
		it 'assigns a pot variable' do 
			expect(game.pot).to eq(0)
		end

		it 'holds the deck of cards' do
			expect(game.deck).to be_a( Deck )
			expect(game.deck.stack).to all(be_a Card)
		end
	end

	describe '#add_player' do
		it 'adds players to the player array' do
			game.add_players(2,100)
			expect(game.players).to all(be_a Player)
		end
		it 'creates players with the entered player pot' do 
			game.add_players(2,100)
			expect(game.players[0].pot).to eq(100)
			expect(game.players[1].pot).to eq(100)
		end
	end


	describe '#deal' do
		before(:each) { game.add_players(2,100) }
		it 'fills each players hand' do
			game.deal
			game.players.each do |player|
				expect(player.hand.full?).to eq(true)
			end
		end

		it 'removes cards from the deck' do
			game.deal
			expect(game.deck.stack.length).to eq(42)
		end
	end

	describe '#iter_turn' do 
		before(:each) { game.add_players(4,100) }
		it 'switches the turn to the next player' do 
			expect(game.turn).to eq(0)
			game.iter_turn
			expect(game.turn).to eq(1)
			game.iter_turn; game.iter_turn
			expect(game.turn).to eq(3)
			game.iter_turn
			expect(game.turn).to eq(0)
		end
	end

	describe '#discard' do 
		before(:each) { game.add_players(2,100); game.deal }
		it 'removes from the player\'s hand' do 
			keep_cards = [game.players[0].hand.player_hand[1], game.players[0].hand.player_hand[3]]
			game.discard(game.players[0], [0,2,4])
			discard_hand = game.players[0].hand.player_hand
			expect(discard_hand).to eq(keep_cards)
		end	
	end


end