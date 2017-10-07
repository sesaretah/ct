class AddChkbxToLab < ActiveRecord::Migration
  def change
    add_column :labs, :chkbxch, :integer
    add_column :labs, :chkbxgr, :integer
    add_column :labs, :chkbxbl, :integer
  end
end
