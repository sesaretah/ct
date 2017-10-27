class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.integer :user_id
      t.string :suggested_type
      t.integer :suggested_id
      t.string :why_type
      t.integer :why_id

      t.timestamps null: false
    end
  end
end
