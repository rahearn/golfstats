module HomeScreenPresentation

  def courses
    rounds.map(&:course).uniq
  end


  def self.extended(base)
    class << base
      helper_method :courses

      def rounds
        Round.includes(:course).order(:date).limit 20
      end
    end if base.instance_of? PagesController
  end

end
