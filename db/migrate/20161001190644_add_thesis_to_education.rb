class AddThesisToEducation < ActiveRecord::Migration
  def change
    add_column :educations, :title, :string
    add_column :educations, :thesis_gpa, :string
  end
end
