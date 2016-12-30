class AddDeltaToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :delta, :boolean, :default => true,
  :null => false
  end
end
