class CreateQuestionaires < ActiveRecord::Migration
  def change
    create_table :questionaires do |t|
      t.text :question
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
