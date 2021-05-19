class RemoveNullConstraintOnBatchDirector < ActiveRecord::Migration[6.1]
  def change
    change_column :batches, :batch_director_id, :integer, null: true
  end
end
