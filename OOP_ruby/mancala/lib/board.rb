class Board
  attr_accessor :cups

  def initialize(name1, name2)
  	@cups = Array.new(14) {Array.new(4) {:stone}}
  	@cups[6], @cups[13] = [], []
  	@player1 = name1
  	@player2 = name2
  end

  def valid_move?(start_pos)
  	if start_pos > 13 || start_pos < 0 || start_pos == 6 || start_pos == 13
  		raise "Invalid starting cup"
  		return false
  	elsif @cups[start_pos].empty?
  		raise "Starting cup is empty"
  		return false
  	end
  	true	
  end

  def make_move(start_pos, current_player_name)
  	stones_num = @cups[start_pos].count
  	@cups[start_pos] = []
  	cur_idx = (start_pos) % 14
  	until stones_num == 0
  		cur_idx = (cur_idx + 1) % 14
  		next if cur_idx == 6 && current_player_name == @player2
  		next if cur_idx == 13 && current_player_name == @player1
  		@cups[cur_idx] << :stone
  		stones_num -= 1
  	end
  	self.render
  	next_turn(cur_idx)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
   	return :prompt if ending_cup_idx == 6 || ending_cup_idx == 13
    return @cups[ending_cup_idx].count == 1 ? :switch : ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  	side1 = (0..5).to_a.all?{ |i| @cups[i].empty? }
  	side2 = (7..12).to_a.all?{ |i| @cups[i].empty? }
  	side1 || side2
  end

  def winner
  	side_1_c, side_2_c = @cups[6].count, @cups[13].count
  	return :draw if side_2_c == side_1_c
  	return @player1 if side_1_c > side_2_c
  	return @player2
  end
end
