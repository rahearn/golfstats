module EquitableCalculator

  def calculate
    [score, max_score].min
  end

  private

  def max_score
    holed.extend CourseHandicap

    if holed.handicap >= 40
      10
    elsif holed.handicap >= 30
      9
    elsif holed.handicap >= 20
      8
    elsif holed.handicap >= 10
      7
    else
      par + 2
    end
  end

end
