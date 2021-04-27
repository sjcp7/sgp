class AddBatchDirectorIdToBatch < ActiveRecord::Migration[6.1]
  def change
    add_reference :batches, :batch_director, null: false
  end
end
