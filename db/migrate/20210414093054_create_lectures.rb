class CreateLectures < ActiveRecord::Migration[6.1]
  def change
    create_table :lectures do |t|
      t.references :course_subject, null: false
      t.references :batch, null: false
      t.references :teacher, null: false

      t.timestamps
    end
  end
end
