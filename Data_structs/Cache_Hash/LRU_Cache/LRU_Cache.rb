class LRUCache
	def initialize(cap)
		#implementation with array is easy, but is really inefficient.
		@cache_arr = []
		@max_cap = cap


	end

	def add(el)
		if @cache.include?(el)
			@cache.delete(el)
			@cache << el
		elsif self.count >= @max_cap
			@cache_arr.shift
			@cache_arr.push(el)
		else
			@cache_arr.push(el)
		end
	end

	def count
		@cache_arr.length
	end

	#shows items in cache, LRU first.
	def show 
		p @cache_arr
	end

end

