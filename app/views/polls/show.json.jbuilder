@pollsections = @poll.pollsections
json.extract! @poll, :id, :title, :created_at, :updated_at
json.pollsections @pollsections do |pollsection|
   json.id pollsection.id
   json.question pollsection.question
   @pollitems = pollsection.pollitems
   json.pollitems @pollitems do |pollitem|
     json.id pollitem.id
     json.content pollitem.content
   end
end
