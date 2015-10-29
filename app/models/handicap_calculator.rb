class HandicapCalculator

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    (average_differential * 9.6).truncate / 10.0 unless sorted_rounds.empty?
  end

  def sorted_rounds
    @sorted_rounds ||= user.recent_rounds.sort do |a,b|
      a.differential <=> b.differential
    end[0, slice_size]
  end

  private

  def average_differential
    sorted_rounds.map(&:differential).sum / sorted_rounds.count
  end

  def slice_size
    case user.recent_rounds.count
    when 5..6   then 1
    when 7..8   then 2
    when 9..10  then 3
    when 11..12 then 4
    when 13..14 then 5
    when 15..16 then 6
    when 17     then 7
    when 18     then 8
    when 19     then 9
    when 20     then 10
    else
      0
    end
  end

end
