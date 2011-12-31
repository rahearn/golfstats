module DifferentialCalculator

  def calculate
    unless partial_round?
      ((score.to_f - course_rating) * 113.0) / course_slope
    end
  end

  private

  def partial_round?
    scorecard.present? && scorecard.holes.any? { |h| h.score.blank? }
  end

  def course_rating
    (scorecard.try(:rating) || rating).to_f
  end

  def course_slope
    (scorecard.try(:slope) || slope).to_f
  end
end
