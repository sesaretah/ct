class AddUserIdToAll < ActiveRecord::Migration
  def change
    add_column :researches, :user_id, :integer
    add_column :honors, :user_id, :integer
    add_column :tags, :user_id, :integer
    add_column :educations, :user_id, :integer
  end
end
