module GarminImporter

  def import_round
    tree = Nokogiri::XML garmin_file.read
    @teebox = Teebox.where(tees: tees, course_id: course_id).first
    self.scorecard = import_scorecard_from tree
  end

  private

  def import_scorecard_from(player_info)
    scorecard = Scorecard.new round: self, stat_order: %w(Putts FIR GIR), course_handicap: course_handicap
    player_info.xpath('//PlayerHole').each do |h|
      hole = h.at_xpath('./HoleNumber').text
      score = h.at_xpath('./HoleScore').text.to_i
      putts = h.at_xpath('./HolePutts').text.to_i
      par = h.at_xpath("//CourseHole/HoleNumber[text()=#{hole}]/../HolePar").text.to_i
      length = @teebox.holes.where(hole: hole).first.try :length unless @teebox.nil?
      scorecard.holes.build hole: hole,
                            length: length,
                            score: score,
                            par: par,
                            handicap: h.at_xpath("//CourseHole/HoleNumber[text()=#{hole}]/../HoleHandicap").text,
                            custom_stats: {'0' => putts,
                                           '1' => fir_value(h.at_xpath('./HoleFairwayHit').text.to_i),
                                           '2' => ((par - 2) == (score - putts) ? 'y' : 'n')
                            }
    end
    scorecard.save
    scorecard
  end

  def fir_value(garmin_value)
    case garmin_value
      when 3; then ''
      when 2; then 'y'
      else
        'n'
    end
  end

end