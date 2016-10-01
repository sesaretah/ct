class AddToEducation < ActiveRecord::Migration
  def change
    add_column :educations, :start_year, :integer
    add_column :educations, :end_year, :integer
  end
end
