class RemoveNullConstraintOnTeacherInLectures < ActiveRecord::Migration[6.1]
  def change
    change_column :lectures, :teacher_id, :integer, null: true
  end
end
