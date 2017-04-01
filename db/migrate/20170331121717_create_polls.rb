class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
