class CreateMobilesettings < ActiveRecord::Migration
  def change
    create_table :mobilesettings do |t|
      t.integer :user_id
      t.string :securephrase
      t.integer :access_via_mobile

      t.timestamps null: false
    end
  end
end
