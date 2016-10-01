class CreateHonors < ActiveRecord::Migration
  def change
    create_table :honors do |t|
      t.string :title
      t.string :year

      t.timestamps null: false
    end
  end
end
