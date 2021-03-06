class MaxIntSet
  attr_reader :max, :store
  def initialize(max)
    @max = max
    @store = Array.new(max) {false}
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" unless is_valid?(num)

    @store[num] = false
  end

  def include?(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, max)
  end

  def validate!(num)
  end
end

########################################################
########################################################
########################################################
########################################################
########################################################
########################################################
########################################################



class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return if self[num].include?(num)
    self[num].push(num)

  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)

    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end



#########################################################
#########################################################
#########################################################
#########################################################
#########################################################
#########################################################
#########################################################



class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return if self[num].include?(num)
    self[num].push(num)
    @count += 1
    resize! if @count == num_buckets
  end

  def remove(num)
    return unless self[num].include?(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) {Array.new}
    @store.flatten.each do |ele|
        new_idx = ele % (num_buckets * 2)
        new_store[new_idx].push(ele)
    end
    @store = new_store
  end
end

