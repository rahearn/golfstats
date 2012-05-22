class AddImportFlagToUser < ActiveRecord::Migration
  def change
    add_column :users, :import_done, :boolean, :default => false
  end
end
