class EquitableStrokeCalculator

  def self.esc_limit(course_handicap)
    if course_handicap >= 40
      10
    elsif course_handicap >= 30
      9
    elsif course_handicap >= 20
      8
    elsif course_handicap >= 10
      7
    else
      :dbl_bogey
    end
  end

  attr_reader :course_handicap

  def initialize(index, slope)
    @course_handicap = CourseHandicap.new(index, slope).handicap
  end

  def calculate(score, par)
    [score, max_score(par)].min
  end

  private

  def max_score(par)
    esc_limit = self.class.esc_limit course_handicap
    esc_limit == :dbl_bogey ? par + 2 : esc_limit
  end

end
