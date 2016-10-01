json.extract! event, :id, :name, :description, :event_date, :start_time, :end_time, :created_at, :updated_at
json.url event_url(event, format: :json)