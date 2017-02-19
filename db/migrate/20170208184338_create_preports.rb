class CreatePreports < ActiveRecord::Migration
  def change
    create_table :preports do |t|
      t.integer :user_id
      t.integer :task_id
      t.text :detail
      t.string :status

      t.timestamps null: false
    end
  end
end
