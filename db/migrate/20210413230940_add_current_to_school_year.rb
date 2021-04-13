class AddCurrentToSchoolYear < ActiveRecord::Migration[6.1]
  def change
    add_column :school_years, :current, :boolean, default: false
  end
end
