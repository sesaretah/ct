class CreateAbuses < ActiveRecord::Migration
  def change
    create_table :abuses do |t|
      t.string :title
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
