json.extract! activity, :id, :user_id, :activity_type, :target_type, :target_id, :middle_type, :middle_id, :detail, :created_at, :updated_at
json.url activity_url(activity, format: :json)