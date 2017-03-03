class AddUserIdToLab < ActiveRecord::Migration
  def change
    add_column :labs, :user_id, :integer
  end
end
