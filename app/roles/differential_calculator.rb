module DifferentialCalculator

  def calculate
    unless partial_round?
      if scorecard.present?
        s = scorecard.holes.select { |h| h.score? }.map do |h|
          h.extend EquitableStrokeCalculator
          h.calculate
        end.reduce :+
      else
        s = score
      end
      ((s.to_f - rating) * 113.0) / slope
    end
  end

  private

  def partial_round?
    scorecard.present? &&
      (scorecard.holes.length != 18 ||
       scorecard.holes.any? { |h| h.score.blank? })
  end

end
