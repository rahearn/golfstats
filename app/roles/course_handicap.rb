module CourseHandicap

  def handicap(user = nil, slope = nil)
    @handicap ||= ((user || self.user).handicap * (slope || self.slope).to_f / 113.0).round
  end

end
