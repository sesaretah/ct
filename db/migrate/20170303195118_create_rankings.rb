class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.string :rankable_type
      t.integer :rankable_id
      t.integer :user_id
      t.string :rank_type

      t.timestamps null: false
    end
  end
end
