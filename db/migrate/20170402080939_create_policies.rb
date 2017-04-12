class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.string :privatable_type
      t.integer :privatable_id
      t.integer :policy_type

      t.timestamps null: false
    end
  end
end
