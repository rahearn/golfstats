module RoundsHelper

  def build_scorecard_for(round)
    if round.scorecard.present?
      round.scorecard
    else
      Scorecard.new(:round => round).tap do |sc|
        (1..18).each do |hole|
          sc.holes.build :hole => hole
        end
      end
    end
  end

end
