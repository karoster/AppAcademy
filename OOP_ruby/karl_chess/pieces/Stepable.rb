module Stepable
	def moves
		possible_moves = []

		self.move_difs.each { |dir| possible_moves += valid_direction(dir) }
		possible_moves
	end

	def move_difs
		raise NotImplementedError.new("move_difs has not been implemented by subclass")
	end

	private

	def valid_direction(dir)
		x, y  = dir[0] + pos[0], dir[1] + pos[1]
		end_pos = [x, y]
		return [] unless board.valid_pos?(end_pos)
		return [end_pos] unless board[end_pos].color == self.color
		[]
	end

end