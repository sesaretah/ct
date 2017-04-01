json.extract! followship, :id, :user_id, :followable_type, :followable_id, :created_at, :updated_at
json.url followship_url(followship, format: :json)