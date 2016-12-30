class AddPTypeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :p_type, :integer
  end
end
