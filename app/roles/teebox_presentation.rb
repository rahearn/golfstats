module TeeboxPresentation

  def teeboxes
    @teeboxes ||= Teebox.where(:course_id => self.id).sort_by { |teebox| tee_order teebox.tees }
  end

  private

  STD_TEES = {
    :red          => 0,
    :gold         => 10,
    :white        => 20,
    :blue         => 30,
    :black        => 40,
    :championship => 45
  }

  def tee_order(tee)
    STD_TEES[tee.downcase.to_sym] || 50
  end
end
