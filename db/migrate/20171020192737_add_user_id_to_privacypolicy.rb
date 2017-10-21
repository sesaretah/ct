class AddUserIdToPrivacypolicy < ActiveRecord::Migration
  def change
    add_column :privacypolicies, :user_id, :integer
  end
end
