class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.integer :confirmable_id
      t.string :confirmable_type
      t.string :confrimable_field
      t.integer :confrimation_stat
      t.string :confrimation_carrier

      t.timestamps null: false
    end
  end
end
