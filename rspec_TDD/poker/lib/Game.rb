require_relative 'Player'
require_relative 'Deck'
require_relative 'Card'
require_relative 'Constants'

class Game
	attr_reader :players, :pot, :turn
	attr_accessor :deck

	

	def initialize
		@pot = 0
		@players = []
		@turn = 0
		@deck = Deck.new
	end

	def add_players(number, player_pot)
		number.times { @players << Player.new(player_pot) }
	end

	def deal
		5.times do
			@players.each { |player| player.take(deck.draw) }
		end
	end

	def show_hands(remaining_players)
		system("clear")
		remaining_players.each_with_index do |player, idx|
			system("clear")
			puts "now showing Player #{idx + 1}'s hand."
			sleep(1)
			puts player.hand.inspect
			sleep(4)
		end
	end

	def ask_discards(remaining_players)
		remaining_players.each do |player|
			puts player.hand.inspect
			puts "would you like to discard some cards? type y for yes."
			if gets.chomp == "y"
				replace_num = discard(player.get_discards, player)
				replace_num.times { player.take(deck.draw) }
			end
			
		end
	end

	def discard(discard_arr, player)
		take_num = discard_arr.length
	 	player.hand.delete(discard_arr)
	 	take_num
	end

	def round_of_actions(players_in)
		bet = 0
		players_remaining = []
		players_in.each do |player|
			case player.action
			when 'f'
				next
			when 'r'
				player.pay(bet)
				@pot += bet
				bet += raise_pot(player)
				players_remaining << player
			when 'c'
				player.pay(bet)
				@pot += bet
				players_remaining << player
			end
		end
		players_remaining
	end

	def deck_reset
		@deck = Deck.new
	end

	def player_reset
		players.each { |player| player.reset }
	end

	def update_remaining(round_winner)
		round_winner.pot += @pot
		@pot = 0
		@players.reject! { |player| player.pot == 0 }
	end


	def play
		i = 0
		until game_over?
			deal
			#puts "first stage #{i}"
			show_hands(@players)
			#puts "2 stage #{i}"
			remaining_players = round_of_actions(@players)
			#puts "3 stage #{i}"
			unless remaining_players.length == 1
				ask_discards(remaining_players) 
			#	puts "4 stage #{i}"
				show_hands(remaining_players)
			#	puts "5 stage #{i}"
				showdown_players = round_of_actions(remaining_players)
			end
			round_winner = C.winner_of(showdown_players)

			update_remaining(round_winner)
			player_reset
			deck_reset
		end

		puts "game over!"
	end

	###Helper Functions###

	def iter_turn
		@turn = (@turn + 1) % players.length
	end

	def raise_pot(player)
		puts "please enter an amount to bet:"
		amt = gets.chomp.to_i
		player.pay(amt)
		@pot += amt
		amt
	end

	def game_over?
		players.length == 1
		
	end

end

g = Game.new
g.add_players(2,100)
g.play
