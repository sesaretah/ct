class CreatePollsections < ActiveRecord::Migration
  def change
    create_table :pollsections do |t|
      t.integer :poll_id
      t.string :question

      t.timestamps null: false
    end
  end
end
