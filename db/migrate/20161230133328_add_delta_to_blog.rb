class AddDeltaToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :delta, :boolean, :default => true,
  :null => false
  end
end
