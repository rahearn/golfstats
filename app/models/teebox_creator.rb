class TeeboxCreator

  attr_reader :scorecard
  def initialize(scorecard)
    @scorecard = scorecard
  end

  def valid?
    round.try(:course_id).present? && holes.count == 18 && holes.all? { |h| h.valid_for_teebox? }
  end

  def call
    teebox = Teebox.find_or_initialize_by(:tees => scorecard.tees.downcase, :course_id => round.course_id).tap do |t|
      t.slope  = scorecard.slope
      t.rating = scorecard.rating
    end

    if teebox.holes.empty?
      holes.each do |h|
        teebox.holes.build(
          :hole     => h.hole,
          :length   => h.length,
          :par      => h.par,
          :handicap => h.handicap
        )
      end
    else
      default_holes = teebox.holes.each
      holes.each do |h|
        dh          = default_holes.next
        dh.length   = h.length
        dh.par      = h.par
        dh.handicap = h.handicap if h.handicap.present?
      end
    end
    teebox.save!
  end

  private

  def round
    scorecard.round
  end

  def holes
    scorecard.holes
  end

end
