class AddPpToResearches < ActiveRecord::Migration
  def change
    add_column :researches, :pp, :string
  end
end
