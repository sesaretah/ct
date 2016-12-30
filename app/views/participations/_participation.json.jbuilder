json.extract! participation, :id, :user_id, :event_id, :adder_id, :role, :created_at, :updated_at
json.url participation_url(participation, format: :json)