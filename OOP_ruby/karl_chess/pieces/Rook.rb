require_relative "Piece.rb"
require_relative "Slideable.rb"


class Rook < Piece
	include Slideable

	def move_dirs
		[:straight]
	end
	def symbol
		color == :white ? "R" : "r"
	end
end