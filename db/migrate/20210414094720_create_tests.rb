class CreateTests < ActiveRecord::Migration[6.1]
  def change
    create_table :tests do |t|
      t.references :student, null: false
      t.references :lecture, null: false
      t.float :score
      t.float :max_score
      t.string :kind
      t.references :school_quarter, null: false

      t.timestamps
    end
  end
end
