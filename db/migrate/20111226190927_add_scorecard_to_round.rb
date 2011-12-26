class AddScorecardToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :scorecard_id, :string
  end
end
