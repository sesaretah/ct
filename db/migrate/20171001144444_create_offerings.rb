class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.integer :course_id
      t.integer :user_id
      t.string :period
      t.integer :year
      t.string :location

      t.timestamps null: false
    end
  end
end
