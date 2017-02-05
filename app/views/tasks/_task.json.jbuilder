json.extract! task, :id, :name, :description, :start_date, :due_date, :status, :created_at, :updated_at
json.url task_url(task, format: :json)