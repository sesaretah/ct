class CreateOffsessions < ActiveRecord::Migration
  def change
    create_table :offsessions do |t|
      t.integer :offering_id
      t.string :name

      t.timestamps null: false
    end
  end
end
