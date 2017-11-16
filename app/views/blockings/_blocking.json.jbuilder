json.extract! blocking, :id, :user_id, :target_id, :blocked_type, :blocked_id, :created_at, :updated_at
json.url blocking_url(blocking, format: :json)