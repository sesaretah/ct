class AddUtidToResearches < ActiveRecord::Migration
  def change
    add_column :researches, :utid, :string
  end
end
