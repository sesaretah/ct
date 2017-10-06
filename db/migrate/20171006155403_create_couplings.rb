class CreateCouplings < ActiveRecord::Migration
  def change
    create_table :couplings do |t|
      t.integer :coupler_id
      t.string :coupler_type
      t.integer :couplee_id
      t.string :couplee_type

      t.timestamps null: false
    end
  end
end
