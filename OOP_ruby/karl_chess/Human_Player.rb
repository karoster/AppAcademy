require_relative "Player"

class Human_Player < Player
	def make_move(board)
		input = nil
		until input
			@display.render
			input = @display.cursor.get_input
			system("clear")
		end
		input
	end

end