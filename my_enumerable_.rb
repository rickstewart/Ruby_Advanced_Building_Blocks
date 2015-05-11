class Array
  def my_each
    if block_given?
      for i in 0..(self.size - 1)
        yield self[i]
      end
    else
      self.to_enum
    end
  end

  def my_each_with_index
    if block_given?
      for i in 0..(self.size - 1)
        yield self[i], i
      end
    else
      self.to_enum
    end
  end
end


class Hash
  def my_each
    if block_given?
      array = self.to_a
      for i in 0..(array.size - 1)
        yield array[i][0], array[i][1]
      end
    else
      self.to_enum
    end
  end


  def my_each_with_index
    def my_each
      if block_given?
        array = self.to_a
        for i in 0..(array.size - 1)
          yield array[i][0], array[i][1], i
        end
      else
        self.to_enum
      end
    end
  end
end

module Enumerable

  def my_select
    if block_given?
      if self.instance_of? Array
        @newArray = []
        self.my_each { |value| @newArray << value if yield value }
        @newArray
      else
        self.instance_of? Hash
        @newHash = {}
        self.my_each { |key, value| @newHash[key] = value if yield key, value }
        @newHash
      end
    else
      self.to_enum
    end
  end

  def my_all?
    @all_true = true
    if self.instance_of? Array
      if block_given?
        self.my_each { |value| @all_true = false if !(yield value) }
        @all_true
      else
        self.my_each { |obj| @all_true = false if !obj }
        @all_true
      end
    else
      self.instance_of? Hash
      if block_given?
        self.my_each { |key, value| @all_true = false if !(yield key, value) }
        @all_true
      else
        self.my_each { |key, obj| @all_true = false if !obj }
        @all_true
      end
    end
  end

  def my_any?
    @any_true = false
    if self.instance_of? Array
      if block_given?
        self.my_each { |value| @any_true = true if (yield value) }
        @any_true
      else
        self.my_each { |obj| @any_true = true if obj }
        @any_true
      end
    else
      self.instance_of? Hash
      if block_given?
        self.my_each { |key, value| @any_true = true if (yield key, value) }
        @any_true
      else
        self.my_each { |key, obj| @any_true = true if obj }
        @any_true
      end
    end
  end

  def my_none?
    @none_true = true
    if self.instance_of? Array
      if block_given?
        self.my_each { |value| @none_true = false if (yield value) }
        @none_true
      else
        self.my_each { |obj| @none_true = false if obj }
        @none_true
      end
    else
      self.instance_of? Hash
      if block_given?
        self.my_each { |key, value| @none_true = false if (yield key, value) }
        @none_true
      else
        self.my_each { |key, obj| @none_true = false if obj }
        @none_true
      end
    end
  end

  def my_count(arg = nil)
    @count = 0
    if block_given?
      if self.instance_of? Array
        self.my_each { |value| @count = @count + 1 if (yield value) }
      else
        self.instance_of? Hash
        self.my_each { |key, value| @count = @count + 1 if (yield key, value) }
      end
    elsif arg.nil?
      self.my_each { | | @count = @count + 1 }
    else
      if self.instance_of? Array
        self.my_each { |value| @count = @count + 1 if (value == arg) }
      else
        self.instance_of? Hash
        self.my_each { |key, value| @count = @count + 1 if (value == arg) }
      end
    end
    @count
  end

  def my_map
    if block_given?
      if self.instance_of? Array
        @newArray = []
        self.my_each { |value| @newArray.push (yield value) }
        @newArray
      else
        self.instance_of? Hash
        @newHash = {}
        self.my_each { |key, value| @newHash[key] = yield key, value }
        @newHash
      end
    else
      self.to_enum
    end
  end

  def my_inject(arg = nil)
    if self.instance_of? Array
      if block_given?
        self.my_each { |accum, value| yield accum, value }
      elsif arg
        self.my_each { |arg, value| yield arg, value }
      else
        self.to_enum
      end
    else
      self.instance_of? Hash
      array_from_hash = self.to_a
      if block_given?
        array_from_hash.my_each { |accum, value| yield accum, value }
      elsif arg
        array_from_hash.my_each { |arg, value| yield arg, value }
      else
        self.to_enum
      end
    end
  end
end


# a = [1, 2, 3, 4, 5]
# b = a.my_each
# puts b.next
# puts b.next
# puts b.next
# puts "=============="
# a.my_each_with_index { |x, y| p x, y }
# puts "----------------------"
# h = {7 => 14, 8 => 16, 9 => 18}
# c= h.to_enum
# puts c.next
# puts c.next
# d = a.my_count { |num| num % 2 == 0 }
# puts d
# e = a.my_count
# puts e
# f = a.my_count(3)
# puts f
# puts "*****************************"
# g = h.map
# puts h
#
