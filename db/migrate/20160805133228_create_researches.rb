class CreateResearches < ActiveRecord::Migration
  def change
    create_table :researches do |t|
      t.string :name
      t.string :pub_year
      t.string :pub_type
      t.string :pub_name
      t.string :pub_authors

      t.timestamps null: false
    end
  end
end
