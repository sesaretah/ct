class AddRankToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :rank, :string
  end
end
