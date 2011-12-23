class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.rememberable
      t.trackable

      t.timestamps

      t.string :email, :name
      t.string :openid_uid, :null => false
      t.string :gender, :limit => 6, :default => 'male'
      t.decimal :handicap, :scale => 1, :precision => 3
    end

    add_index :users, :openid_uid,           :unique => true
    add_index :users, :email,                :unique => true
    # add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end
end
