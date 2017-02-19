class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.string :name
      t.text :about
      t.text :missions
      t.string :tel
      t.text :address

      t.timestamps null: false
    end
  end
end
