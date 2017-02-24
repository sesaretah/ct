class AddDeltaToGoods < ActiveRecord::Migration
  def change
    add_column :goods, :delta, :boolean, :default => true,
  :null => false
  end
end
