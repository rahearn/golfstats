class CourseHandicap

  attr_writer :index, :slope

  def initialize(index, slope)
    @index = index
    @slope = slope
  end

  def handicap
    ((index * slope) / 113.0).round
  end

  def index
    Float(@index)
  end

  def slope
    Float(@slope)
  end
end
