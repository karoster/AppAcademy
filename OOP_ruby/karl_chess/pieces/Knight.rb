require_relative "Piece.rb"
require_relative "Stepable.rb"

class Knight < Piece
	include Stepable

	def symbol
		color == :white ? "N" : "n"
	end

	def move_difs
		[[1,2], [2,1], [-1,2], [2,-1], [-1,-2], [-2,-1], [1,-2], [-2,1]]
	end

end