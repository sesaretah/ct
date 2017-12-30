class AddIsAdminToAccesscontrol < ActiveRecord::Migration
  def change
    add_column :accesscontrols, :is_admin, :integer
  end
end
