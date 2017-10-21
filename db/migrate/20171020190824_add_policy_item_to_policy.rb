class AddPolicyItemToPolicy < ActiveRecord::Migration
  def change
    add_column :policies, :policy_item, :string
  end
end
