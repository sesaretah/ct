class AddValueToResearch < ActiveRecord::Migration
  def change
    add_column :researches, :value, :integer
  end
end
