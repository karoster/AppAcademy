require_relative "Piece.rb"
require_relative "Slideable.rb"

class Pawn < Piece
	def moves
		forward_steps + side_attacks
	end

	def symbol
		color == :white ? "P" : "p"
	end

	private

	def at_start_row?
		pos[0] == (color == :white) ? 1 : 6
	end

	def forward_dir
		color == :white ? -1 : 1
	end

	#I feel like this is sloppy
	def forward_steps
		x, y = pos
		step = [x + forward_dir, y]

		return [] unless board.valid_pos?(step) && board.empty?(step)

		steps = [step]
		step2 = [x + 2 * forward_dir, y]
		steps << step2 if at_start_row? && board.empty?(step2)

		steps
	end

	def side_attacks
		attack_steps = []
		x,y = pos
		attacks = [[x + forward_dir, y + 1], [x + forward_dir, y - 1]]

		attacks.select do |attack_pos|
			next false unless board.valid_pos?(attack_pos)
			next false if board.empty?(attack_pos)

			true if board[attack_pos].color != color
		end
		
	end
end