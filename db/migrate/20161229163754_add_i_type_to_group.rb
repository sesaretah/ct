class AddITypeToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :i_type, :integer
  end
end
