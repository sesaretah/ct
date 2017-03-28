json.extract! book, :id, :title, :authors, :publisher, :city, :pub_year, :created_at, :updated_at
json.url book_url(book, format: :json)