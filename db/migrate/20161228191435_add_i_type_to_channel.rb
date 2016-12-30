class AddITypeToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :i_type, :integer
  end
end
