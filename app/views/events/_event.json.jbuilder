json.extract! event, :id, :name, :description, :event_date, :start_time, :end_time, :created_at, :updated_at
json.url event_url(event, format: :json)
json.image root_url + url_for(event.avatar(:thumb))
