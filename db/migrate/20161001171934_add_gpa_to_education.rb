class AddGpaToEducation < ActiveRecord::Migration
  def change
    add_column :educations, :gpa, :float
  end
end
