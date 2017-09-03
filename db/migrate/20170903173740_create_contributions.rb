class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.integer :user_id
      t.integer :research_id
      t.string :role

      t.timestamps null: false
    end
  end
end
