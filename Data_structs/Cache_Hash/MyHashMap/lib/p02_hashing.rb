class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    tester = self.flatten.map.with_index { |ele, idx| ele.ord + idx }.join("").to_i
    tester.hash
  end
end

class String
  def hash
    self.split("").hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = []
    self.each do |key,val| 
      arr << (key.to_s + val.to_s).split("")
    end
    return arr.sort.hash

    0
  end

end


