class RemoveScoreFromTests < ActiveRecord::Migration[6.1]
  def change
    remove_column :tests, :score
  end
end
