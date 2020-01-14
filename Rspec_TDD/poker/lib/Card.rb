require_relative 'Constants'

class Card

	attr_reader :type, :suit
	
	
	def initialize(type, suit)
		@type = type
		@suit = suit
	end

	def to_s
		type + suit
	end

	def value
		C.types.index(type)
	end

end
