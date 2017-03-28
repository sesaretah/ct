class CreateTheses < ActiveRecord::Migration
  def change
    create_table :theses do |t|
      t.string :title
      t.string :student
      t.string :thesis_type
      t.string :faculty
      t.string :tdate
      t.string :supervisor_utid
      t.string :advisor_utid
      t.integer :advisor_id
      t.integer :supervisor_id

      t.timestamps null: false
    end
  end
end
