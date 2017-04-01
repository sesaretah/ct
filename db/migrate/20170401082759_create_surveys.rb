class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :pollitem_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
