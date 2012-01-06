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

  def scorecard_value(try)
    try || '&nbsp;'.html_safe
  end

  def last_column_class(hole)
    hole == 18 ? 'lastUnit' : ''
  end

end
