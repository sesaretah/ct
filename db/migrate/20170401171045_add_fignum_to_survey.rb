class AddFignumToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :fignum, :integer
  end
end
