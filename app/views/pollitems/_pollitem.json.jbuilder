json.extract! pollitem, :id, :content, :poll_id, :created_at, :updated_at
json.url pollitem_url(pollitem, format: :json)