class CreateFollowships < ActiveRecord::Migration
  def change
    create_table :followships do |t|
      t.integer :user_id
      t.string :followable_type
      t.integer :followable_id

      t.timestamps null: false
    end
  end
end
