json.extract! contribution, :id, :user_id, :research_id, :role, :created_at, :updated_at
json.url contribution_url(contribution, format: :json)