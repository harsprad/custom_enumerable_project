module Enumerable
  def my_each_with_index
    index = 0
    self.my_each do |elem|
      yield(elem, index)
      index += 1
    end
  end

  def my_select
    result = []
    self.each do |elem|
      result << elem if yield(elem)
    end
    self.class.try_convert(result) || result
  end

  def my_all?
    for elem in self
      return false unless yield(elem)
    end
    true
  end

  def my_any?
    self.my_each do |elem|
      return true if yield(elem)
    end
    false
  end

  def my_none?
    self.my_any? { |elem| yield(elem) } == false
  end

  def my_count(item = nil)
    return self.size unless item || block_given?
    return self.select { |elem| elem == item }.size if item

    self.select { |elem| yield(elem) }.size
  end

  def my_map
    result = []
    self.each do |elem|
      result << yield(elem)
    end
    self.class.try_convert(result) || result
  end

  def my_inject(initial_operand = nil)
    return "error" unless block_given?
    return self if self.size == 1

    index = 0
    self_copy = self.map { |elem| elem }
    initial_operand = self_copy.shift unless initial_operand
    self_copy_size = self_copy.size
    while index < self_copy_size
      initial_operand = yield(initial_operand, self_copy.shift)
      index += 1
    end
    initial_operand
  end

end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    return if self.length == 0
    yield(self.first)
    self[1..].my_each { |elem| yield(elem) }
    self
  end

  def to_hash
    self.to_h
  end
end

class Hash
  def my_each
    return if self.length == 0
    first_key = self.keys[0]
    yield(first_key, self[first_key])
    self.slice(*self.keys[1..]).my_each { |key, elem| yield(key, elem) }
    self
  end

  def index(elem)
    self.to_a.index(elem)
  end
end

