module EquitableStrokeCalculator

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

  def calculate
    [score, max_score].min
  end

  private

  def max_score
    holed.extend CourseHandicap

    esc_limit = EquitableStrokeCalculator.esc_limit holed.handicap
    esc_limit == :dbl_bogey ? par + 2 : esc_limit
  end

end
