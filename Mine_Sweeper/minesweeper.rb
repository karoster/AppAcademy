require_relative "board.rb"
require "byebug"


class MineSweep
	attr_reader :board
	def initialize
		@board = Board.new
		@board.add_mines
		@board.track_bombs
	end


	def render
		@board.render
	end

	def get_move_type
		puts "please enter the move you would like to perform."
		puts "'f' to flag a square, 'r' to reveal"
		move = nil
		until move && valid_move_type?(move)
			move = gets.chomp
			unless valid_move_type?(move)
				puts "that is an invalid move type"
			end
		end
		move
	end


	def get_valid_pos
		puts "please enter a coordinate position. (e.g. 0,0)"
		pos = nil
		until pos && valid_pos?(pos)
			pos = parse_pos(gets.chomp)

			unless valid_pos?(pos)
				puts "that is an invalid position!"
			end
		end
		pos
	end

	def take_turn
		system("clear")
		@board.render
		move_type = get_move_type
		pos = get_valid_pos
		move_type == 'r' ? @board.reveal(pos) : @board.flag(pos)
	end

	def game_over?
		if @board.game_over?
			return true
		end
		false
	end	

	def run
		take_turn until game_over?
		puts "game is over"
		render
	end


	### Helper fxns ###

	def valid_pos?(pos)
		pos.all? {|ele| ele.is_a?(Integer)} && 
		pos.length == 2 &&
		pos.all? { |ele| (0..8).include?(ele) }
	end

	def valid_move_type?(move)
		move == 'r' || move == 'f'
	end

	def parse_pos(pos)
		pos.split(",").map(&:to_i)
	end
end

test = MineSweep.new
test.run