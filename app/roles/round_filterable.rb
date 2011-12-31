module RoundFilterable

  def sorted_rounds
    recent_rounds.sort do |a,b|
      a.differential <=> b.differential
    end[0, slice_size(recent_rounds.count)]
  end

  def recent_rounds
    rounds.where('differential IS NOT NULL').limit 20
  end

  private

  def slice_size(total_rounds)
    case total_rounds
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
