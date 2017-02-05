class AddDeltaToTags < ActiveRecord::Migration
  def change
      add_column :tags, :delta, :boolean, :default => true,
    :null => false
    end
end
