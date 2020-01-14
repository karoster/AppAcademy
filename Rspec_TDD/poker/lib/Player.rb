require_relative 'Hand'
require_relative 'Card'

class Player
	attr_reader :pot, :hand

	def initialize(player_pot)
		@hand = Hand.new
		@pot = player_pot
	end

	def take(card)
		raise ArgumentError unless card.is_a?(Card)
		raise "too many cards in hand" if hand.full?
		@hand.add_card(card)
	end

	# def discard
	# 	take_num = get_discards.length
	# 	@hand.delete(get_discards)
	# end

	def action
		actions = %w(r f c)
		puts "Type f to fold, r to raise, or c to call the bet"
		begin
			user_action = gets.chomp
			raise "that is not a valid action" unless actions.include?(user_action)
		rescue
			retry
		end
		user_action
	end


	def pay(amt)
		@pot -= amt
	end

	def reset
		@hand = Hand.new
	end

	###Helper methods###

	def get_discards
		puts "please enter your cards, 0-4 you would like to discard. Separated by spaces."
		begin
			discards = gets.chomp.split(" ").map(&:to_i)
			valid_discard?(discards)
		rescue
			puts "Those are invalid positions, enter 0 - 4 seperated by spaces"
			retry
		end
		discards
	end

	def valid_discard?(indices)
		indices.all? { |idx| idx.between?(0,5) }
	end

end