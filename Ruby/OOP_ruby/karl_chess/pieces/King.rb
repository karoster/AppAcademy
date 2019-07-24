require_relative "Piece.rb"
require_relative "Stepable.rb"

class King < Piece
	include Stepable

	def symbol
		color == :white ? "K" : "k"
	end

	def move_difs
		[[1,0],[0,1],[1,1],[-1,0],[-1,-1],[0,-1],[1,-1],[-1,1]]		
	end

end