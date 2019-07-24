require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :next_mover_mark, :prev_move_pos, :board

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)

    if @board.over?
      return true if @board.winner == opposing_move(evaluator)
      return false if @board.winner.nil? || @board.winner == evaluator
    end

    if evaluator == @next_mover_mark
      return children.all? { |child| child.losing_node?(evaluator) }
    else
      return children.any? { |child| child.losing_node?(evaluator) }
    end

  end

  def winning_node?(evaluator)

    if @board.over?
      return true if @board.winner == evaluator
      return false if @board.winner.nil? || @board.winner != evaluator
    end

    if evaluator == @next_mover_mark
      return children.any? { |child| child.winning_node?(evaluator) }
    else
      return children.all? { |child| child.winning_node?(evaluator) }
    end

  end


  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_arr = []
    (0..2).each do |row|
      (0..2).each do |col|
        duped_board = @board.dup
        next unless duped_board.empty?([row,col])
        duped_board[[row, col]] = @next_mover_mark
        children_arr << TicTacToeNode.new(duped_board, opposing_move(@next_mover_mark), [row, col])
      end
    end
    children_arr
  end

  ###Helper Fxns###
  def opposing_move(evaluator)
    evaluator == :x ? :o : :x
  end
end
