class CreateBatches < ActiveRecord::Migration[6.1]
  def change
    create_table :batches do |t|
      t.references :course, null: false
      t.references :school_year, null: false
      t.references :school_grade, null: false

      t.timestamps
    end
  end
end
