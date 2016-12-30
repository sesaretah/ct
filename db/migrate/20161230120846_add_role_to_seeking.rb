class AddRoleToSeeking < ActiveRecord::Migration
  def change
    add_column :seekings, :role, :integer
  end
end
