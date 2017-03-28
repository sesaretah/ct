class AddUtidToBooks < ActiveRecord::Migration
  def change
    add_column :books, :utid, :string
  end
end
