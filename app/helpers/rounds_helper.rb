module RoundsHelper

  def build_scorecard_for(round)
    if round.scorecard.present?
      round.scorecard
    else
      Scorecard.new(:round => round).tap do |sc|
        build_holes sc
      end
    end
  end

  def build_holes(scorecard)
    if @teebox.present?
      @teebox.holes.each do |hole|
        scorecard.holes.build hole.attributes
      end
    else
      (1..18).each do |hole|
        scorecard.holes.build :hole => hole
      end
    end
  end

  def scorecard_value(try)
    if try.present?
      try.numeric? ? try : (try.true? ? 'Yes' : 'No')
    else
      '&nbsp;'.html_safe
    end
  end

  def differential_if_active(round)
    if user_signed_in?
      current_user.extend RoundFilter unless current_user.respond_to?(:sorted_rounds)
      "(#{round.display_differential})" if current_user.sorted_rounds.include?(round)
    end
  end
end
