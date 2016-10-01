json.extract! comment, :id, :content, :user_id, :commentable_class, :commentable_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)