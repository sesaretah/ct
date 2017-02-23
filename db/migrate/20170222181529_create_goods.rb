class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :name
      t.text :description
      t.string :price
      t.integer :user_id
      t.integer :category_id
      t.integer :sub_category_id
      t.date :deadline

      t.timestamps null: false
    end
  end
end
