require_relative "./Slideable.rb"
require_relative "./Stepable.rb"

class Piece
	attr_reader :board, :color
	attr_accessor :pos
	def initialize(pos, board, color)
		raise "invalid position" unless board.valid_pos?(pos)
		raise "invalid color" unless %i(white black).include?(color)

		@board, @pos, @color = board, pos, color

		board.add_piece(self, pos)
	end

	def to_s
		" #{symbol} "
	end

	def symbol
		
		raise "Not implemented"
	end

	def empty?
		false
	end
end
