class AddOpenidProviderToUser < ActiveRecord::Migration
  def up
    add_column :users, :openid_provider, :string

    execute %{UPDATE users SET openid_provider = 'no provider'}

    change_column :users, :openid_provider, :string, null: false
  end

  def down
    remove_column :users, :openid_provider
  end
end
