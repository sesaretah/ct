class AddGTypeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :g_type, :integer
  end
end
