class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    take_turn until game_over
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    unless game_over
      round_success_message
      @sequence_length += 1
      system("clear")
    end
  end

  def show_sequence
    add_random_color
    seq.each_with_index do |col, idx|
      puts "#{idx + 1}. #{col}"
      sleep(1)
      system("clear")
    end
  end

  def require_sequence
    puts "Enter the shown sequence, one color at a time: "
    @sequence_length.times do |i|
      guess = gets.chomp
      if guess != @seq[i]
        @game_over = true
        break
      end
    end
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    puts "congratulations, that is correct!"
    puts "you have succesfully completed #{@sequence_length} rounds!"
    puts "get ready for the next round!"
    sleep(2)
  end

  def game_over_message
    puts "That is incorrect!"
    puts "your final score was #{@sequence_length}"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

g = Simon.new
g.play
