class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.integer :user_id
      t.integer :p_type
      t.integer :g_type
      t.integer :i_type

      t.timestamps null: false
    end
  end
end
