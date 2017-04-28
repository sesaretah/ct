class CreateCsessions < ActiveRecord::Migration
  def change
    create_table :csessions do |t|
      t.integer :course_id
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
