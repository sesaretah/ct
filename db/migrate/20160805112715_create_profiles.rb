class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surename
      t.date :birthdate
      t.string :sex
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
