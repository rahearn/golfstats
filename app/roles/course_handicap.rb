module CourseHandicap

  def handicap
    @handicap ||= (user.handicap * slope.to_f / 113.0).round
  end

end
