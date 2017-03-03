json.extract! questionaire, :id, :question, :user_id, :created_at, :updated_at
json.url questionaire_url(questionaire, format: :json)