require_relative "Piece.rb"
require_relative "Stepable.rb"

class Knight < Piece
	include Stepable

	def symbol
		color == :white ? "N" : "n"
	end

end