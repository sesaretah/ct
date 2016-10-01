class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :name
      t.string :grade
      t.string :city
      t.string :country

      t.timestamps null: false
    end
  end
end
