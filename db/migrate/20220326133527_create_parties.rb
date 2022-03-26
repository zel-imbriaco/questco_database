class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.string :name
      t.integer :rank
      t.boolean :active

      t.timestamps
    end
  end
end
