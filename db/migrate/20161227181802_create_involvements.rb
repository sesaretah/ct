class CreateInvolvements < ActiveRecord::Migration
  def change
    create_table :involvements do |t|
      t.integer :user_id
      t.integer :channel_id
      t.integer :adder_id
      t.integer :role

      t.timestamps null: false
    end
  end
end
