require "colorize"
require_relative "Board"
require_relative "cursor"
class Display
	attr_accessor :cursor
	def initialize(board)
		@board = board
		@cursor = Cursor.new([0,0], board)
	end

	def build_board
		@board.board.map.with_index do |row, i|
			build_row(row, i)
		end
	end

	def build_row(row, i)
		row.map.with_index do |sq, j|
			b_col = background_of(i,j)
			sq.to_s.colorize(b_col)
		end
	end

	def background_of(i,j)
		if @cursor.cursor_pos == [i,j]
			bg = :green
		elsif (i*7+j).odd?
			bg = :cyan
		else
			bg = :white
		end
		{background: bg}
	end

	def render
		build_board.each do |row|
			puts row.join("")

		end
	end

	def sudo_play
		until @board.in_check(:black) || @board.in_check(:white)
			self.render
			@cursor.get_input
			system("clear")
		end
		puts "in check"
	end

end

# b = Board.new
# d = Display.new(b)
# d.sudo_play