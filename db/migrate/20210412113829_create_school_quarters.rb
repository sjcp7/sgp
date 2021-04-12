class CreateSchoolQuarters < ActiveRecord::Migration[6.1]
  def change
    create_table :school_quarters do |t|
      t.integer :quarter

      t.timestamps
    end
  end
end
