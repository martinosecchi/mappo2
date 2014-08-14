class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.string :type
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
