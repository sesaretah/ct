class AddFacultyToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :faculty, :string
  end
end
