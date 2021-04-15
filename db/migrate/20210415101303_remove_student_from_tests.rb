class RemoveStudentFromTests < ActiveRecord::Migration[6.1]
  def change
    remove_column :tests, :student_id
  end
end
