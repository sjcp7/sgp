class CreateEnrollments < ActiveRecord::Migration[6.1]
  def change
    create_table :enrollments do |t|
      t.references :batch, null: false
      t.references :student, null: false

      t.timestamps
    end
  end
end
