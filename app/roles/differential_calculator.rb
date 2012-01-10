module DifferentialCalculator

  def calculate
    unless partial_round?
      ((score.to_f - rating) * 113.0) / slope
    end
  end

  private

  def partial_round?
    scorecard.present? && scorecard.holes.any? { |h| h.score.blank? }
  end

end
