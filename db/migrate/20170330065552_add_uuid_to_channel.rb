class AddUuidToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :uuid, :string
  end
end
