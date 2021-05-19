class AddNifToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :nif, :string
  end
end
