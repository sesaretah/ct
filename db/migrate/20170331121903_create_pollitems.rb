class CreatePollitems < ActiveRecord::Migration
  def change
    create_table :pollitems do |t|
      t.string :content
      t.integer :poll_id

      t.timestamps null: false
    end
  end
end
