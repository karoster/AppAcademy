require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    ll = bucket(key)
    if self.include?(key) 
      ll.update(key,val)
    else
      ll.append(key, val)
      @count += 1
      resize! if @count == num_buckets
    end
  end

  def get(key)
    #returns the value stored in key
    bucket(key).get(key)
  end

  def delete(key)
    return unless self.include?(key)
    bucket(key).remove(key) 
    @count -= 1
  end

  def each(&block)
    @store.flatten.each do |ll|
      ll.each do |node|
        block.call(node.key, node.val)
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) {LinkedList.new}
    @store.flatten.each do |linkl|
      linkl.each do |node|
        new_idx = node.key.hash % (num_buckets * 2)
        new_store[new_idx].append(node.key, node.val)
      end
    end
    @store = new_store
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
