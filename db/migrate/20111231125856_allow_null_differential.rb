class AllowNullDifferential < ActiveRecord::Migration
  def up
    change_column :rounds, :differential, :float, :null => true
  end

  def down
    change_column :rounds, :differential, :float, :null => false
  end
end
