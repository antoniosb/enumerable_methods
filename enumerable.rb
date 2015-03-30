module Enumerable
  
  def my_each
    element, index = self.first, 1
    while element
      yield element
      element, index = self.drop(index).first, index + 1
    end
    self
  end

  def my_each_with_index
    element, index = self.first, 1
    while element
      yield element, index-1
      element, index = self.drop(index).first, index + 1
    end
    self
  end

  def my_select
    element, index = self.first, 1
    result = []
    while element
      result << element if yield element
      element, index = self.drop(index).first, index + 1
    end
    result
  end

  def my_all?
    element, index = self.first, 1
    result = true
    while element
      result = (yield element) && result
      element, index = self.drop(index).first, index + 1
    end
    result
  end

  def my_any?
    element, index = self.first, 1
    result = false
    while element
      result = result || (yield element)
      element, index = self.drop(index).first, index + 1
    end
    result
  end

  def my_none?
    element, index = self.first, 1
    result = false
    while element
      result = (yield element) && false
      element, index = self.drop(index).first, index + 1
    end
    result
  end

  def my_count item = nil
    element, index = self.first, 1
    result = 0
    while element
      if item
        result += 1 if element == item
      elsif block_given?
        result +=1 if yield element
      else
        result += 1
      end      
      element, index = self.drop(index).first, index + 1
    end
    result
  end

  def my_map
    element, index = self.first, 1
    result = []
    while element
      result[index-1] = yield element
      element, index = self.drop(index).first, index + 1
    end
    result
  end

  def my_inject(*args)
    result = self.first
    case args.size
    when 0
      element, index = self.first, 1
      while element
        result = yield result, element
        element, index = self.drop(index).first, index + 1
      end
      result
    when 1
      if args.first.is_a? Symbol
        element, index = self.first, 1
        while element
          result = result.send(args.first, element) unless index == 1
          element, index = self.drop(index).first, index + 1
        end
        result
      elsif args.first.is_a? Fixnum
        element, index = self.first, 1
        result = args.first
        while element
          result = yield result, element
          element, index = self.drop(index).first, index + 1
        end
        result
      else
        raise ArgumentError.new
      end
    when 2
      element, index = self.first, 1
      result = args.first
      while element
        result = result.send(args.last, element) unless index == 1
        element, index = self.drop(index).first, index + 1
      end
      result
    else
      raise ArgumentError.new
    end
  end

  def multiply_els
    raise ArgumentError.new unless self.my_all? { |elem| elem.is_a? Fixnum }
    self.my_inject(:*)
  end

end
