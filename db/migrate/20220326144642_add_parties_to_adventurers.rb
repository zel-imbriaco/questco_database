class AddPartiesToAdventurers < ActiveRecord::Migration[5.2]
  def change
    add_reference :adventurers, :party, foreign_key: true
  end
end
