require_relative "Piece.rb"
require_relative "Slideable.rb"


class Queen < Piece
	include Slideable

	def move_dirs
		[:diagonal, :straight]
	end

	def symbol
		color == :white ? "Q" : "q"
	end
end