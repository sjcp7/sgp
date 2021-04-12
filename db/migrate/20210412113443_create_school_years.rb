class CreateSchoolYears < ActiveRecord::Migration[6.1]
  def change
    create_table :school_years do |t|
      t.string :year

      t.timestamps
    end
  end
end
