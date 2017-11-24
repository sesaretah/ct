json.extract! group, :id, :name, :description, :created_at, :updated_at
json.url group_url(group, format: :json)
json.image root_url + url_for(group.avatar(:thumb))
