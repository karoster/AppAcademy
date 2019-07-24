require_relative "./Slideable.rb"
require_relative "./Stepable.rb"
require "colorize"

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
		return color == :white ? " #{symbol} ".red : " #{symbol} ".black 
		" #{symbol} "
	end

	def symbol
				
		raise "Not implemented"
	end

	def empty?
		false
	end

	def move_into_check?(end_pos)
		copy = @board.dup
		copy.move_piece!(pos, end_pos)
		copy.in_check?(color)
	end

	def valid_moves
		moves.reject do |move|
			move_into_check?(move)
		end
		
	end

	def inspect
		self.to_s
	end


end
