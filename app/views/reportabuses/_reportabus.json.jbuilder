json.extract! reportabus, :id, :abuse_id, :detail, :abused_type, :abused_id, :abuser_id, :reporter_id, :created_at, :updated_at
json.url reportabus_url(reportabus, format: :json)