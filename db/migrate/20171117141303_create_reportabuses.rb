class CreateReportabuses < ActiveRecord::Migration
  def change
    create_table :reportabuses do |t|
      t.integer :abuse_id
      t.text :detail
      t.string :abused_type
      t.integer :abused_id
      t.integer :abuser_id
      t.integer :reporter_id

      t.timestamps null: false
    end
  end
end
