json.extract! project, :id, :name, :aims, :owner, :created_at, :updated_at
json.url project_url(project, format: :json)
json.image root_url + url_for(project.avatar(:thumb))
