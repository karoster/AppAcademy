#require "Enumberable"
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get_node(key)
    self.each { |node| return node if node.key == key }
    nil
  end

  def get(key)
    node = get_node(key)
    return nil if node.nil?
    node.val
  end

  def include?(key)
    self.get_node(key).is_a?(Node) ? true : false
  end


  def append(key, val)
    #not sure if this is what is desired...
    self.update(key, val) if self.include?(key)
    append_node = Node.new(key,val)
    append_node.prev = @tail.prev
    append_node.next = @tail
    @tail.prev.next = append_node
    @tail.prev = append_node
    append_node
  end

  def update(key, val)
    return unless self.include?(key)
    update_node = get_node(key)
    update_node.val = val

  end

  def remove(key)
    rem_node = get_node(key)
    return if rem_node.nil?
    rem_node.prev.next = rem_node.next
    rem_node.next.prev = rem_node.prev
  end

  def each(&block)
    cur = @head
    until cur == @tail.prev
      cur = cur.next
      block.call(cur)
    end

  end

  #include Enumberable

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

end
