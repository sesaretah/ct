class AddUtidToEducation < ActiveRecord::Migration
  def change
    add_column :educations, :utid, :integer
  end
end
