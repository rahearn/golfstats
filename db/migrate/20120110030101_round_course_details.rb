class RoundCourseDetails < ActiveRecord::Migration

  def change
    add_column :rounds, :slope, :integer
    add_column :rounds, :rating, :decimal, :scale => 1, :precision => 4
  end

end
