class CreateCourseSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :course_subjects do |t|
      t.references :course, null: false
      t.references :subject, null: false
      t.references :school_grade, null: false

      t.timestamps
    end
  end
end
