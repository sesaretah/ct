class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.string :activity_type
      t.string :target_type
      t.integer :target_id
      t.string :middle_type
      t.integer :middle_id
      t.integer :detail

      t.timestamps null: false
    end
  end
end
