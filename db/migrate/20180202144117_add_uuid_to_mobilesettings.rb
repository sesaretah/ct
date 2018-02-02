class AddUuidToMobilesettings < ActiveRecord::Migration
  def change
    add_column :mobilesettings, :uuid, :string
  end
end
