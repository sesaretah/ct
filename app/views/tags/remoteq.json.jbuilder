json.array!(@tags) do |tag|
  json.extract! tag, :title
end
