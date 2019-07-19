require_relative "Piece.rb"
require_relative "Stepable.rb"

class King < Piece
	include Stepable

	def symbol
		color == :white ? "K" : "k"
	end

end