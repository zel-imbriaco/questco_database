class AddVenturers < ActiveRecord::Migration[5.2]
  def change
    create_table :adventurers do |t|
      t.string :name
      t.integer :level
      t.boolean :alive

      t.timestamps
    end
  end
end
