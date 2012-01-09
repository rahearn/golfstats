module HomeScreenPresentation

  def courses
    rounds.map(&:course).uniq
  end

end
