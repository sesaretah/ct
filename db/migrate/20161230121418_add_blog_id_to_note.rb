class AddBlogIdToNote < ActiveRecord::Migration
  def change
    add_column :notes, :blog_id, :integer
  end
end
