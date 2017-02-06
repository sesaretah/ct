class AddToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :project_type, :string
    add_column :projects, :location, :string
    add_column :projects, :definition, :text
    add_column :projects, :novelties, :text
    add_column :projects, :methods, :text
    add_column :projects, :standards, :text
    add_column :projects, :outputs, :text
  end
end
