class PolyTreeNode
	attr_reader :parent, :value, :children


	def initialize(value)
		@value = value
		@parent = nil
		@children = []
	end

	def parent=(root)
		#removing self from old parent's children unless that parent is nil
		@parent.children.delete(self) unless @parent.nil?
		#changing the current parent to the arg
		@parent = root
		#returning if that was a nil value, otherwise adding this to root.children
		return if root.nil?
		#
		root.children << self
	end

	def add_child(node)
		node.parent = self
		#@children << node unless @children.include?(node)
	end

	def remove_child(node)
		if node && @children.include?(node)
			node.parent = nil
		else
			raise "This node is not a child..."
		end
	end

	def dfs(target_val)
		return self if @value == target_val
		@children.each do |node|
			search_val = node.dfs(target_val)
			return search_val unless search_val.nil?
		end
		nil
	end

	def bfs(target_val)
		search_arr = [self]
		until search_arr.empty?
			inspect_node = search_arr.shift
			return inspect_node if inspect_node.value == target_val
			search_arr += inspect_node.children
			#search_arr.concat(inspect_node.children)
		end
		nil
	end
end