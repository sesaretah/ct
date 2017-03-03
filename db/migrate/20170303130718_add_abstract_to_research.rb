class AddAbstractToResearch < ActiveRecord::Migration
  def change
    add_column :researches, :abstract, :text
  end
end
