module HomeScreenPresentation

  def courses
    display_rounds.map(&:course).uniq
  end

  def display_rounds
    Round.includes(:course).order(:date).limit 20
  end

  def self.extended(base)
    class << base
      helper_method :courses
    end if base.is_a? ApplicationController
  end

end
