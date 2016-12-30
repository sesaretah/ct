class AddGroupTypeToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :p_type, :integer
  end
end
