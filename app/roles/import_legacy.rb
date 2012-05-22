module ImportLegacy

  def import_legacy(file)
    @saved_courses = {}
    @xml_courses = {}
    @tree = Nokogiri::XML file.read

    set_player_attrs
    save_courses
    save_rounds

    self.import_done = true
    self.save!

    @success = true
  rescue => ex
    Rails.logger.error "Error importing #{id}: #{ex.message}"
    Rails.logger.debug ex.backtrace.join("\n")
    @success = false
  end

  def import_successful?
    !!@success
  end

  private

  def set_player_attrs
    player = @tree.root
    self.name = "#{player['firstName']} #{player['lastName']}" unless name?
    self.gender = player['male'] == 'true' ? 'male' : 'female'
    save!
  end

  def save_courses
    @tree.xpath('//COURSES/COURSE').each do |node|
      original_course_id = node['id']
      course = Course.find_or_create_by_name_and_location node['name'], node['location']
      node.xpath('.//NOTES/NOTE').each do |note|
        CourseNote.find_or_initialize_by_course_id_and_user_id(course.id, id).tap do |cn|
          cn.note = "#{cn.note} #{note.content}".strip
        end.save!
      end

      @saved_courses[original_course_id] = course
      @xml_courses[original_course_id] = node
    end
  end

  def save_rounds
    @tree.xpath('//ROUNDS/ROUND').each do |node|
      original_course_id = node['course']
      rounds.create!(
        {
          course: @saved_courses[original_course_id],
          date: Date.strptime(node['date'], '%m/%d/%y'),
          slope: @xml_courses[original_course_id]['slope'],
          rating: @xml_courses[original_course_id]['rating'],
          score: node['score']
        }.tap do |attrs|
          if node.xpath('.//NOTE').first.content.present?
            attrs[:notes] = node.xpath('.//NOTE').first.content
          end
          if node['type'] == 'DETAILED'
            attrs[:scorecard] = {
              user_id: id,
              tees: @xml_courses[original_course_id]['tees'],
              stat_order: ['Putts', 'Penalties', 'Duffs', 'FIR', 'GIR']
            }
            attrs[:scorecard][:holes_attributes] = [].tap do |holes|
              node.xpath('.//HOLES/HOLE').each do |hole|
                holes << {
                  hole: hole['number'],
                  score: hole['score'],
                  length: @xml_courses[original_course_id].xpath(%|.//HOLES/HOLE[@number="#{hole['number']}"]|).first['yardage'],
                  par: @xml_courses[original_course_id].xpath(%|.//HOLES/HOLE[@number="#{hole['number']}"]|).first['par'],
                  custom_stats: {
                    '0' => hole['putts'],
                    '1' => hole['penalties'],
                    '2' => hole['duffs'],
                    '3' => hole['fir'] == 'true' ? 'y' : 'n',
                    '4' => hole['gir'] == 'true' ? 'y' : 'n'
                  }
                }
              end
            end
          end
        end
      )
    end
  end
end
