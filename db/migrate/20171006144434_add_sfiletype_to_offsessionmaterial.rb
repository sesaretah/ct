class AddSfiletypeToOffsessionmaterial < ActiveRecord::Migration
  def change
    add_column :offsessionmaterials, :sfiletype, :string
  end
end
