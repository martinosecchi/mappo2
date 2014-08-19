class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name
      t.date :start
      t.date :end
      t.text :places
      t.text :extra

      t.timestamps

      t.belongs_to :dataset
    end
  end
end
