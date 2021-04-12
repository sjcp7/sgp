class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.string :description
      t.string :acronymn

      t.timestamps
    end
  end
end
