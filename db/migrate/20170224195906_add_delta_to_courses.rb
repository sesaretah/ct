class AddDeltaToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :delta, :boolean, :default => true,
  :null => false
  end
end
