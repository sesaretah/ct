class AddDeltaToEvent < ActiveRecord::Migration
  def change
    add_column :events, :delta, :boolean, :default => true,
  :null => false
  end
end
