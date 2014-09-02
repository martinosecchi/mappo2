class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.string :title
      t.string :category
      t.text :description
      t.timestamps

      t.belongs_to :works
      t.belongs_to :user
    end
  end
end
