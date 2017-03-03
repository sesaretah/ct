class CreateQitems < ActiveRecord::Migration
  def change
    create_table :qitems do |t|
      t.string :content
      t.integer :questionaire_id

      t.timestamps null: false
    end
  end
end
