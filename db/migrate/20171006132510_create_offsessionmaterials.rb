class CreateOffsessionmaterials < ActiveRecord::Migration
  def change
    create_table :offsessionmaterials do |t|
      t.string :title
      t.integer :offsession_id

      t.timestamps null: false
    end
  end
end
