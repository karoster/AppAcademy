require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer

  def move(game, mark)
  	node = TicTacToeNode.new(game.board, mark)
  	position = winning_move(node)
  	position = stall_move(node) if position.nil?
  	position
  end

  ###Helper Fxns###
  def winning_move(node)
  	pos = nil
  	node.children.each do |child|
  		if child.winning_node?(node.next_mover_mark)
  			pos = child.prev_move_pos
  		end
  	end
  	pos
  end

  def stall_move(node)
  	node.children.each do |child|
  		return child.prev_move_pos unless child.losing_node?(node.next_mover_mark)
  	end
  	raise "All moves result in loss"
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
