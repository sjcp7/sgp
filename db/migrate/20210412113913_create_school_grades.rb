class CreateSchoolGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :school_grades do |t|
      t.integer :grade

      t.timestamps
    end
  end
end
