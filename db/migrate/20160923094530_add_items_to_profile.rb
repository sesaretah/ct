class AddItemsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :fathername, :string
    add_column :profiles, :ssn, :string
    add_column :profiles, :phonenumber, :string
    add_column :profiles, :mobilenumber, :string
  end
end
