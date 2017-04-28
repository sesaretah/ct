json.extract! csession, :id, :course_id, :title, :description, :created_at, :updated_at
json.url csession_url(csession, format: :json)