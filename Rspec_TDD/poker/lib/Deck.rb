require_relative 'Card'
require_relative 'Constants'

class Deck
	attr_accessor :stack

	def self.build_deck
		stack = []
		C.types.each do |type|
			C.suits.each { |suit| stack << Card.new(type, suit) }
		end
		stack.shuffle
	end

	def initialize
		@stack = Deck.build_deck
	end

	def shuffle
		@stack = @stack.shuffle
	end

	def draw
		@stack.pop
	end

end

