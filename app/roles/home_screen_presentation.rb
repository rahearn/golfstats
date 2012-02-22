module HomeScreenPresentation

  def courses
    rounds.map(&:course).uniq
  end


  def self.extended(base)
    class << base
      helper_method :courses
    end if base.is_a? ApplicationController

    class << base
      def rounds
        Round.includes(:course).order(:date).limit 20
      end
    end unless base.respond_to? :rounds
  end

end
