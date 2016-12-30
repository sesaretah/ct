class AddDeltaToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :delta, :boolean, :default => true,
  :null => false
  end
end
