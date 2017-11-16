class CreateBlockings < ActiveRecord::Migration
  def change
    create_table :blockings do |t|
      t.integer :user_id
      t.integer :target_id
      t.string :blocked_type
      t.integer :blocked_id

      t.timestamps null: false
    end
  end
end
