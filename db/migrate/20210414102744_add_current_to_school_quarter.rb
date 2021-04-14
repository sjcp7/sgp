class AddCurrentToSchoolQuarter < ActiveRecord::Migration[6.1]
  def change
    add_column :school_quarters, :current, :boolean
  end
end
