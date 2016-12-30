class CreateGroupings < ActiveRecord::Migration
  def change
    create_table :groupings do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :adder_id
      t.integer :role

      t.timestamps null: false
    end
  end
end
