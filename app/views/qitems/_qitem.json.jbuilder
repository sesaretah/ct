json.extract! qitem, :id, :content, :questionaire_id, :created_at, :updated_at
json.url qitem_url(qitem, format: :json)