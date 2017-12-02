class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :notifiable_type
      t.integer :notifiable_id
      t.string :notifiee_type
      t.integer :notfiee_id
      t.text :content

      t.timestamps null: false
    end
  end
end
