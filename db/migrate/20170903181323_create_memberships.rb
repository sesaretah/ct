class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :lab_id
      t.integer :user_id
      t.string :role

      t.timestamps null: false
    end
  end
end
