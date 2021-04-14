class AddDescriptionToBatches < ActiveRecord::Migration[6.1]
  def change
    add_column :batches, :description, :string
  end
end
