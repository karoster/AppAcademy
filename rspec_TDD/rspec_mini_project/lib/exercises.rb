class Array
	def my_uniq
		arr = []
		self.each { |ele| arr << ele unless arr.include?(ele) }
		arr
	end

	def two_sum
		pairs_arr = []
		(0...self.length).each do |idx|
			(idx+1...self.length).each do |idx2|
				pairs_arr << [idx, idx2] if self[idx] + self[idx2] == 0
			end
		end
		pairs_arr
	end

	def my_transpose
		return [] if self.empty?
		raise ArgumentError.new("Array is not square") if self.length != self[0].length
		dim = self.length
		transposed = Array.new(dim) {Array.new(dim)}
		(0...dim).each do |row|
			(0...dim).each { |col| transposed[col][row] = self[row][col] }
		end
		transposed
	end

end


def stock_picker(arr)
	best_entry_exit = nil
	best_profit = 0
		
	(0...arr.length).each do |buy_day|
		(buy_day...arr.length).each do |sell_day|
			profit = arr[sell_day] - arr[buy_day]
			if profit > best_profit
				best_entry_exit = [buy_day, sell_day]
				best_profit = profit
			end
		end
	end
	best_entry_exit		
end