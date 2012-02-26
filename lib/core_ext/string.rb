class String

  def true?
    %w(yes y true t).include? downcase
  end

  def false?
    %w(no n false f).include? downcase
  end

  def numeric?
    !(/^-?(?:\d{1,3}(?:,\d{3})+|\d*)(?:|\.\d*)$/ =~ self).nil?
  end

end
