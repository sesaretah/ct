class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :authors
      t.string :publisher
      t.string :city
      t.string :pub_year

      t.timestamps null: false
    end
  end
end
