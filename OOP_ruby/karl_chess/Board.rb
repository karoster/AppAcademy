#require_relative "Piece"
require_relative "./pieces/Included.rb"

class Board
	attr_accessor :board

	def initialize(filled = true)
		@null_piece = NullPiece.instance
		build_board(filled)
	end

	def [](pos)
		raise "invalid position" unless valid_pos?(pos)
		
		x,y = pos
		@board[x][y]
	end

	#could maybe add the position change to the piece's pos var here...
	def []=(pos, val)
		raise "invalid position" unless valid_pos?(pos)

		x,y = pos
		@board[x][y] = val
	end

	def add_piece(piece, pos)
		raise "position already filled" unless empty?(pos)
		self[pos] = piece
	end

	def move_piece(start_pos, end_pos)
		raise ArgumentError.new("no piece at start pos") if empty?(start_pos)
		piece = self[start_pos]
		raise ArgumentError.new("That is an invalid move") unless piece.moves.include?(end_pos)
		raise ArgumentError.new("You can't put yourself in check!") unless piece.valid_moves.include?(end_pos)

		move_piece!(start_pos,end_pos)
	end
	def move_piece!(start_pos, end_pos)
		raise ArgumentError.new("invalid end position") unless self.valid_pos?(end_pos)

		self[start_pos].pos = end_pos
		self[start_pos], self[end_pos] = @null_piece, self[start_pos]
	end

	def empty?(pos)
		self[pos].empty?
	end

	###Helper fxns###
	def valid_pos?(pos)
		pos.all? {|idx| (0...8).include?(idx)}
	end

	def fill_royalty(color)
		royalty = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
		row_idx = color == :white ? 7 : 0
		royalty.each_with_index do |piece_type, col_idx|
			piece = piece_type.new([row_idx, col_idx], self, color)
		end

	end



	def fill_pawns(color)
		row_idx = color == :white ? 6 : 1
		8.times do |col_idx|
			Pawn.new([row_idx,col_idx], self, color)
		end
		
	end

	def build_board(fill)
		@board = Array.new(8) {Array.new(8) {@null_piece}}
		return unless fill
		%i(white black).each do |color|
			fill_royalty(color)
			fill_pawns(color)
		end
		@board
	end

	def pieces
		@board.flatten.reject(&:empty?)
	end

	def find_king(color)
		pieces.each do |sq|
			return sq.pos if sq.class == King && sq.color == color
		end
		raise "No kings found..."
		nil
	end

	def in_check?(color)
		king_pos = find_king(color)
		enemies = @board.flatten.select {|sq| !sq.empty? && sq.color != color }
		enemies.any? {|sq| sq.moves.include?(king_pos) }
	end

	def dup
		duped = Board.new(false)
		pieces.each do |piece|
			piece.class.new(piece.pos, duped, piece.color)
		end
		duped
	end

	def check_mate?(color)
		piece_color = pieces.select{ |piece| piece.color == color }
		!piece_color.any?{ |piece| piece.valid_moves.length > 0 }
	end

end
