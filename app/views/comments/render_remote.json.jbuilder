json.array!(Comment.last(5)) do |comment|
    json.content comment.content
    json.image root_url + url_for(comment.user.profile.avatar(:thumb))
    json.user_id comment.user_id
    json.created_at_date JalaliDate.to_jalali(comment.created_at)
    json.created_at_time comment.created_at.strftime("%H:%M")
end