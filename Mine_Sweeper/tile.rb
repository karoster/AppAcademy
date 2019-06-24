class Tile
	attr_accessor :flagged, :revealed, :surrounding

	def initialize(bomb_bool)
		@bomb = bomb_bool
		@surrounding = nil
		@flagged = false
		@revealed = false
	end

	def to_s
		if revealed
			return "B" if bomb?
			return surrounding == 0 ? " " : surrounding.to_s
		elsif flagged
			return "F"
		else
			return "*"
		end
	end

	def bomb?
		@bomb
	end

	def add_bomb
		@bomb = true
	end


	def flagged?
		@flagged
	end

	def revealed?
		@revealed
	end

	def flip
		@revealed = true
	end


end