json.extract! recipient, :id, :user_id, :message_id, :created_at, :updated_at
json.url recipient_url(recipient, format: :json)