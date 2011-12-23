class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, :location, :null => false

      t.timestamps
    end

    add_index :courses, :name
    add_index :courses, :location
    add_index :courses, [:name, :location], :unique => true
  end
end
