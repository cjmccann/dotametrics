class CreateHeroRecords < ActiveRecord::Migration
  def change
    create_table :hero_records do |t|

      t.timestamps
    end
  end
end
