class CreateOperacts < ActiveRecord::Migration
  def change
    create_table :operacts do |t|
      t.string :title
      t.integer :user_id
      t.string :start_date_j
      t.string :end_date_j
      t.string :country
      t.string :city
      t.string :utid

      t.timestamps null: false
    end
  end
end
