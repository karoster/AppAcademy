require_relative "Card"
require_relative "Constants"

class Hand
	attr_reader :player_hand, :best_hand, :pairs_count, :combos
	def initialize
		@player_hand = []
		@pairs_count = Hash.new(0)
		@best_hand = nil
		@combos = []
	end

	def add_card(card)
		raise "hand is full" if full?
		@player_hand << card 
		if full?
			update_count
			update_best
		end
	end

	def update_count
		@pairs_count.clear
		@player_hand.each { |card| @pairs_count[card.type] += 1 }
	end

	def update_best
		@combos = []
		@combos << check_pairs
		@combos << check_straight
		@combos << check_flush
		@combos << check_royal

		@best_hand = best_combo
	end

	def best_combo
		return :royal_flush if combos.include?(:royal)
		return :straight_flush if combos.include?(:straight) && combos.include?(:flush)
		return :four_kind if combos.include?(:four_kind)
		return :full_house if combos.include?(:full_house)
		return :flush if combos.include?(:flush)
		return :straight if combos.include?(:straight)
		return :three_kind if combos.include?(:three_kind)
		return :two_pair if combos.include?(:two_pair)
		return :pair if combos.include?(:pair)

		:high
	end


	#private
	def check_pairs
		#going through the different types of card pairings
		case @pairs_count.values.sort
		when [1, 4] then return :four_kind
		when [2, 3] then return :full_house
		when [1, 1, 3] then return :three_kind
		when [1, 2, 2] then return :two_pair
		when [1, 1, 1, 2] then return :pair
		else return nil
		end
	end

	def check_straight
		#sorting the player's hand by increasing card value (Ace high)
		sorted_hand = C.sorter(@player_hand)
		(0...4).each do |i|
			#Checking to see if the value of each subsequent card is one higher than the previous
			return unless sorted_hand[i+1].value - sorted_hand[i].value == 1
		end
		:straight
	end

	def check_flush
		#checking to see if all cards have the same suit as the first card in the hand
		return unless @player_hand.all? { |card| @player_hand[0].suit == card.suit }
		:flush
	end

	def check_royal
		#checking to see if all the royal cards are in the players hand
		return unless %w(A Q K J 10).all? { |type| @player_hand.map(&:type).include?(type) }
		return unless @combos.include?(:flush) && @combos.include?(:straight)
		:royal
	end

###Helper Fxns###
	def full?
		return true if @player_hand.length == 5
		false
	end

	def delete(del_arr)
		@player_hand.delete_if.with_index { |ele, idx| del_arr.include?(idx) }		
	end

	def inspect
		@player_hand.join(" ")
	end

end


