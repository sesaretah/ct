json.extract! event, :id, :name, :description, :event_date, :start_time, :end_time, :created_at, :updated_at
json.url event_url(event, format: :json)
json.image root_url + url_for(event.avatar(:thumb))

json.comments do
    json.array!(event.comments.last(5)) do |comment|
        json.id comment.id
        json.commentable_type  comment.commentable_type
        json.commentable_id comment.commentable_id
        json.content comment.content
        json.image root_url + url_for(comment.user.profile.avatar(:thumb))
        json.user_id comment.user_id
        json.created_at_date JalaliDate.to_jalali(comment.created_at)
        json.created_at_time comment.created_at.strftime("%H:%M")
    end
  end
