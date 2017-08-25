json.extract! pollsection, :id, :poll_id, :question, :created_at, :updated_at
@pollitems = pollsection.pollitems
json.pollitems @pollitems do |pollitem|
  json.id pollitem.id
  json.content pollitem.content
end
