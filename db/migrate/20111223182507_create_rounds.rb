class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.date :date,                :null => false
      t.integer :score,            :null => false
      t.float :differential,       :null => false
      t.belongs_to :user, :course, :null => false
      t.text :notes

      t.timestamps
    end
    add_index :rounds, :user_id
    add_index :rounds, :course_id
  end
end
