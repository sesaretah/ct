@name = profile.name + ' ' + profile.surename
#json.extract! profile, :id, :name, :surename, :created_at, :updated_at
json.name @name 
json.url profile_url(profile, format: :json)
json.image root_url + url_for(profile.avatar(:thumb))
