class CreateSeekings < ActiveRecord::Migration
  def change
    create_table :seekings do |t|
      t.integer :user_id
      t.integer :blog_id

      t.timestamps null: false
    end
  end
end
