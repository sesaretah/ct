class AddPollsectionIdToPollitem < ActiveRecord::Migration
  def change
    add_column :pollitems, :pollsection_id, :integer
  end
end
