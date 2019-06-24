require_relative "tile.rb"

class Board
	attr_reader :grid


	def self.empty_grid
		grid = Array.new(9) do |subarr|
			Array.new(9) { Tile.new(false) }
		end
		grid
	end

	def initialize(grid = Board.empty_grid)
		@grid = grid
	end

	def track_bombs
		(0..8).each do |i|
			(0..8).each do |j|
				count = neighbors_with_bombs(i,j)
				self[[i,j]].surrounding = count
			end
		end
	end


	def add_mines
		while self.bomb_count < 10
			x = rand(9)
			y = rand(9)
			self[[x,y]].add_bomb
		end
	end


	def render
		puts "#{" "} #{(0..8).to_a.join(" ")}"
		@grid.each_with_index do |row, idx|
			puts "#{idx} #{row.join(" ")}"
		end
	end


	def [](pos)
		x,y = pos
		@grid[x][y]
	end

	def []=(pos, value)
		x,y = pos
		@grid[x][y] = value
	end

	def reveal(pos)
		tile = self[pos]

		return nil if tile.revealed?

		tile.flip

		return nil if tile.flagged?
		return nil if tile.bomb?
		return nil if tile.surrounding > 0

		i,j = pos
		(-1..1).each do |i_off|
			(-1..1).each do |j_off|
				off_pos = [i+i_off, j+j_off]
				puts off_pos
				next if out_of_bounds?(off_pos)
				self.reveal(off_pos)
			end
		end
		nil
	end

	def game_over?
		if bomb_found?
			puts "you found a bomb!"
			return true
		end
		if game_won?
			puts "you've won!"
			return true
		end
		false
	end

	### Helper Fxns ###

	def neighbors_with_bombs(i,j)
		count = 0
		(-1..1).each do |i_off|
			(-1..1).each do |j_off|
				next if i_off == 0 && j_off == 0
				pos = [i+i_off, j+j_off]

				next if out_of_bounds?(pos)

				count += 1 if self[pos].bomb?
			end
		end
		count
	end

	def game_won?
		non_revealed = @grid.inject(0) do |mem, var|
			mem += var.count{ |tile| !tile.revealed? }
		end
		return true if non_revealed == 10
		false
	end

	def bomb_count
		@grid.inject(0) do |mem, var|
			mem += var.count{ |tile| tile.bomb? }
		end
	end

	def flag(pos)
		self[pos].flagged = !(self[pos].flagged)
	end

	def bomb_found?
		@grid.any? do |row|
			row.any? do |tile|
				tile.bomb? && tile.revealed?
			end
		end
	end

	def out_of_bounds?(pos)
		x,y = pos
		return false if (0..8).include?(x) && (0..8).include?(y)
		true
	end

end



