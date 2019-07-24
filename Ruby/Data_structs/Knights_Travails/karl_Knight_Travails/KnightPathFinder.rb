require_relative"PolyNodeTree.rb"
class KnightPathFinder
	OFFSETS = [[1,2],[2,1],
		[-1,2],[2,-1],
		[1,-2],[-2,1],
		[-1,-2],[-2,-1]]

	def self.valid_moves(pos)

		OFFSETS.map do |offset|
			[pos[0] + offset[0], pos[1] + offset[1]]
		end.select do |position|
			position.all?{ |coord| (0..7).include?(coord) }
		end
	end


	def initialize(pos)
		@root_node = PolyTreeNode.new(pos)
		@considered_positions = [pos]
		build_move_tree
	end

	def new_move_positions(pos)
		add_positions = KnightPathFinder.valid_moves(pos).select do |ele|
			!@considered_positions.include?(ele)
		end
		@considered_positions.concat(add_positions)
		add_positions
	end

	def build_move_tree
		move_arr = [@root_node]
		until move_arr.empty?
			root = move_arr.shift
			new_positions = new_move_positions(root.value)
			new_nodes = new_positions.map{ |pos| PolyTreeNode.new(pos) }
			new_nodes.each { |child| child.parent = root }
			move_arr.concat(new_nodes)
		end

		nil
	end

	def find_path(end_pos)
		@final_node = @root_node.dfs(end_pos)
		trace_back_path
	end

	def trace_back_path
		path = [@final_node.value]
		parent_node = @final_node.parent
		until parent_node == nil
			path << parent_node.value
			parent_node = parent_node.parent
		end
		path.reverse
	end

	### Helper Methods ###

end
test = KnightPathFinder.new([0,0])
p test.find_path([6,2])

