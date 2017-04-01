json.extract! survey, :id, :pollitem_id, :user_id, :created_at, :updated_at
json.url survey_url(survey, format: :json)