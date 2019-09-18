require_relative "Display"
require_relative "Human_Player"


class Game
	def initialize
		@game_board = Board.new(true)
		@display = Display.new(@game_board)
		@player1 = Human_Player.new(:white, @display)
		@player2 = Human_Player.new(:black, @display)
		@current_player = @player1
	end

	def game_over
		@game_board.check_mate?(:white) || @game_board.check_mate?(:black)
	end

	def winner
		return "white" if @game_board.check_mate?(:black)
		return "black" if @game_board.check_mate?(:white)
	end

	def play_game
		until game_over
			show_turn
			begin
			start_pos = @current_player.make_move(@game_board)
			raise "That is not your piece" if @game_board[start_pos].color != @current_player.color
			end_pos = @current_player.make_move(@game_board)
			@game_board.move_piece(start_pos, end_pos)
			rescue => e 
				puts e.message
				retry
			end
			swap_turn!
		end
		puts "congratulations, #{winner} wins!"
	end

	private

	def swap_turn!
		@current_player = (@current_player == @player1) ? @player2 : @player1	
	end

	def show_turn
		puts "it is #{@current_player}'s turn. press enter on piece you wish to move, and enter again where you want to put it."		
	end

	def notify_players
	end

end
g = Game.new
g.play_game