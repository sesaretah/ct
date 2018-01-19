class AddTokenToMobilesettings < ActiveRecord::Migration
  def change
    add_column :mobilesettings, :token, :text
  end
end
