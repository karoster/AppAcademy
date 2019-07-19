require_relative "Piece.rb"
require_relative "Slideable.rb"

class Bishop < Piece
	include Slideable

	def move_dirs
		[:diagonal]
	end
	def symbol
		color == :white ? "B" : "b"
	end
end