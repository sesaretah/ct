json.extract! lab, :id, :name, :about, :missions, :tel, :address, :created_at, :updated_at
json.url lab_url(lab, format: :json)
json.image root_url + url_for(lab.avatar(:thumb))
