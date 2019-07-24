class Stack	

	def initialize
		@stack = []
		
	end

	def push(el)
		@stack.push(el)
	end

	def pop
		@stack.pop
	end

	def peek
		@stack.last
	end

	def inspect
		@stack
	end

end

class Queue

	def initialize
		@queue = []
	end

	def enqueue(el)
		@queue.unshift(el)
	end

	def dequeue
		@queue.pop
	end

	def peek
		@queue.last
	end

	def inspect
		@queue
	end

end

class Map

	def initialize
		@map = []
	end

	def get(key)
		@map.each { |pair| return pair if pair[0] == key }
	end

	def delete(key)
		@map.each { |pair| @map.delete(pair) if pair[0] == key }
	end

	def set(key, value)
		self.delete(key)
		@map << [key,value]
	end

	def show
		p @map
	end

end
