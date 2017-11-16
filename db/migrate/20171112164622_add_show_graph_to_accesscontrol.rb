class AddShowGraphToAccesscontrol < ActiveRecord::Migration
  def change
    add_column :accesscontrols, :show_graph, :integer
  end
end
