class CreateLocationWorks < ActiveRecord::Migration
  def up
  	create_table :location_works do |t|
  		t.belongs_to :location
  		t.belongs_to :work
  	end
  end

  def down
  	drop_table :location_works
  end
end
