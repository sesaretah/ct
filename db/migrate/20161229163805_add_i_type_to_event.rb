class AddITypeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :i_type, :integer
  end
end
