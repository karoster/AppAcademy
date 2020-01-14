require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      node = @map.get(key)
      val = node.val
      update_node!(node)
    else
      val = calc!(key)

    end
    val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    eject! if count >= @max
    insert_uncached(key, val)
    val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    key = node.key
    value = node.val
    @store.remove(key)
    new_node = @store.append(key,value)
    @map.set(key, new_node)
  end

  def eject!
    key = @store.first.key
    @store.remove(key)
    @map.delete(key)
  end

  ### Helper fxns ###

  def insert_uncached(key, val)
    new_node = @store.append(key, val)

    @map.set(key, new_node)
  end
end
