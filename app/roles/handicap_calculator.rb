module HandicapCalculator

  def calculate
    extend RoundFilter

    (average_differential * 9.6).truncate / 10.0 unless sorted_rounds.empty?
  end

  private

  def average_differential
    sorted_rounds.map(&:differential).sum / sorted_rounds.count
  end
end
