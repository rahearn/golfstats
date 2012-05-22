module TeeboxCreator

  def create_teebox?
    holes.count == 18 && holes.all? { |h| h.valid_for_teebox? }
  end

  def create_teebox
    teebox = Teebox.find_or_initialize_by(:tees => tees.downcase, :course_id => round.course_id).tap do |t|
      t.slope  = slope
      t.rating = rating
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

end
