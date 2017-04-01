class AddGTypeToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :g_type, :integer
  end
end
