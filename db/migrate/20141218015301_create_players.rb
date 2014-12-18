class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.references :heroes, index: true
      t.references :matches, index: true
      t.references :stats, index: true

      t.timestamps
    end
  end
end
