class Array

  def each_key
    each_index { |index| yield index.to_s }
  end

  def each_with_key
    each_with_index { |obj, index| yield obj, index.to_s }
  end

end
