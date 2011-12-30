module DifferentialCalculator

  def calculate
    ((score.to_f - course_rating) * 113.0) / course_slope
  end

  private

  def course_rating
    (scorecard.try(:rating) || rating).to_f
  end

  def course_slope
    (scorecard.try(:slope) || slope).to_f
  end
end
