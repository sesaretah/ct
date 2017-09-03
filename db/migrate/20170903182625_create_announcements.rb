class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.integer :lab_id
      t.integer :user_id
      t.string :title
      t.text :content

      t.timestamps null: false
    end
  end
end
