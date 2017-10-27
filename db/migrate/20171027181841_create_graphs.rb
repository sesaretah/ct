class CreateGraphs < ActiveRecord::Migration
  def change
    create_table :graphs do |t|
      t.text :nodes
      t.text :edges

      t.timestamps null: false
    end
  end
end
