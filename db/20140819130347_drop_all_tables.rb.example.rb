class DropAllTables < ActiveRecord::Migration
  def up
  	drop_table :locations
  	drop_table :works
  	drop_table :location_works
  	drop_table :datasets
  end

  def down
  end
end
