class CreateCourseNotes < ActiveRecord::Migration
  def change
    create_table :course_notes do |t|
      t.text :note
      t.belongs_to :user
      t.belongs_to :course

      t.timestamps
    end

    add_index :course_notes, :user_id
    add_index :course_notes, :course_id
  end
end
