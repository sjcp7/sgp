class CreateStudentTests < ActiveRecord::Migration[6.1]
  def change
    create_table :student_tests do |t|
      t.references :test, null: false
      t.references :student, null: false
      t.float :score
      t.timestamps
    end
  end
end
