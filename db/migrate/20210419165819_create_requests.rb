class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.references :teacher, null: false
      t.references :test, null: false
      t.text :message

      t.timestamps
    end
  end
end