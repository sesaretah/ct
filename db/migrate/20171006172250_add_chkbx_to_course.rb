class AddChkbxToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :chkbxch, :integer
    add_column :courses, :chkbxgr, :integer
    add_column :courses, :chkbxbl, :integer
  end
end
