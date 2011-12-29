module RoundsHelper

  def build_scorecard_for(round)
    Scorecard.new(:round => round).tap do |sc|
      (1..18).each do |hole|
        sc.holes.build :hole => hole
      end
    end
  end

end
