@name = profile.name + ' ' + profile.surename
#json.extract! profile, :id, :name, :surename, :created_at, :updated_at
json.id profile.id
json.name @name
json.sex profile.sex
json.url profile_url(profile, format: :json)
json.image root_url + url_for(profile.avatar(:thumb))
