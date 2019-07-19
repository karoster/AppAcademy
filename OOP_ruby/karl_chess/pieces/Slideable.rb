module Slideable
	DIRECTIONS = {:diagonal => [[1,1],[-1,-1],[1,-1],[-1,1]], :straight => [[0,1],[1,0],[-1,0],[0,-1]]}

	def moves
		possible_move = []
		#mapping the return value of move_dirs from the class this module is included in
		dirs = self.move_dirs.inject([]){ |mem, move_type| mem += DIRECTIONS[move_type] }
		# finding all possible moves for that piece
		dirs.each { |dir| possible_move += check_direction(dir) }
		possible_move
	end

	#checking the move of one possible direction
	def check_direction(dir)
		directional_moves = []
		cur_pos = pos
		#p cur_pos
		
		#p dir

		loop do
			curx, cury = cur_pos[0] + dir[0], cur_pos[1] + dir[1]
			cur_pos = [curx, cury]
			break unless board.valid_pos?(cur_pos)

			if board[cur_pos].empty?
				directional_moves << cur_pos
			else 
				#piece is not the same color, and the tile is not empty, can take that piece.
				directional_moves << cur_pos if board[cur_pos].color != color
				break 
			end
		end
		
		directional_moves
	end

	#if this is true, piece is blocked by own piece

	private

	def move_dirs
		#implement in class module belongs to
		raise NotImplementedError.new("Move_dirs not implemented in piece class")
	end
end