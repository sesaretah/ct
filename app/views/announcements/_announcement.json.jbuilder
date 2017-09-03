json.extract! announcement, :id, :lab_id, :user_id, :title, :content, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)