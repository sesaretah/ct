class CreateGrantings < ActiveRecord::Migration
  def change
    create_table :grantings do |t|
      t.integer :role_id
      t.integer :user_id
      t.integer :granter_id

      t.timestamps null: false
    end
  end
end
