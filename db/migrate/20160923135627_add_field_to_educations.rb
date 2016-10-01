class AddFieldToEducations < ActiveRecord::Migration
  def change
    add_column :educations, :field, :string
  end
end
