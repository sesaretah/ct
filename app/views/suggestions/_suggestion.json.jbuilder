json.extract! suggestion, :id, :user_id, :suggested_type, :suggested_id, :why_type, :why_id, :created_at, :updated_at
json.url suggestion_url(suggestion, format: :json)