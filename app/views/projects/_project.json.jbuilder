json.extract! project, :id, :name, :aims, :project_type, :location, :definition, :novelties, :methods, :standards, :outputs ,:owner, :created_at, :updated_at
json.url project_url(project, format: :json)
json.image root_url + url_for(project.avatar(:thumb))
