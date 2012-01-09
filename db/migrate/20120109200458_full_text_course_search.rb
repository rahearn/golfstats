class FullTextCourseSearch < ActiveRecord::Migration
  def up
    execute %|
      CREATE INDEX courses_ft_name_idx ON courses USING gin(to_tsvector('english', name));
      CREATE INDEX courses_ft_location_idx ON courses USING gin(to_tsvector('english', location));
      |
  end

  def down
    execute %|
      DROP INDEX courses_ft_location_idx;
      DROP INDEX courses_ft_name_idx;
      |
  end
end
