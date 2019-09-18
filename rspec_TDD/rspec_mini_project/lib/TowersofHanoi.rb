

class HanoiGame
	attr_accessor :rod0, :rod1, :rod2

	def initialize
		@rod0 = [4,3,2,1]
		@rod1 = []
		@rod2 = []
	end

	def move
		begin
			puts "please enter a stack you wish to take from (0-2), and a stack you wish to give to (0-2)."
			take, give = gets.chomp.split(" ").map(&:to_i)
			move!(take, give)
		rescue => e
			puts e.message
			retry
		end
	end

	def move!(take, give)
		raise "you cannot place a larger disk onto a smaller one disk" if !rods[give].empty? && rods[take].last > rods[give].last
		rods[give].push(rods[take].pop)
	end

	def won?
		if @rod0.empty? && (@rod1.empty? || @rod2.empty?)
			return true if @rod2 == [4,3,2,1] || @rod1 == [4,3,2,1]
		end
		false
	end

	def play
		until won?
			display_tower
			move
			system("clear")	
		end
		puts "congratulations"
	end

	def display_tower
		p rods
	end


	###Helper functions###
	def rods
		[@rod0, @rod1, @rod2]
	end

end

