json.extract! blog, :id, :title, :user_id, :p_type, :g_type, :i_type, :created_at, :updated_at
json.notes blog.notes, :id, :title
json.url blog_url(blog, format: :json)
