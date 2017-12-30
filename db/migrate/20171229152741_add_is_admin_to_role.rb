class AddIsAdminToRole < ActiveRecord::Migration
  def change
    add_column :roles, :is_admin, :integer
  end
end
