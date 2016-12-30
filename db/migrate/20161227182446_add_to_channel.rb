class AddToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :delta, :boolean, :default => true,
  :null => false

    add_column :channels, :g_type, :integer
    add_column :channels, :p_type, :integer
  end
end
