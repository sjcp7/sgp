class AddLockedToTests < ActiveRecord::Migration[6.1]
  def change
    add_column :tests, :locked, :boolean, default: false
  end
end
