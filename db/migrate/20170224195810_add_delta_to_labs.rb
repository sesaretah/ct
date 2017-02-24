class AddDeltaToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :delta, :boolean, :default => true,
  :null => false
  end
end
