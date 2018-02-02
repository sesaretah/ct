json.extract! group, :id, :name, :description, :created_at, :updated_at
json.url group_url(group, format: :json)
json.image root_url + url_for(group.avatar(:thumb))

json.comments do
    json.array!(group.comments.last(5)) do |comment|
        json.id comment.id
        json.commentable_type  comment.commentable_type
        json.commentable_id comment.commentable_id
        json.content comment.content
        json.image root_url + url_for(comment.user.profile.avatar(:thumb))
        @ms = Mobilesetting.where(user_id: comment.user_id).first
        if !@ms.blank?
          json.uuid @ms.uuid
        else
          json.uuid 0
        end
        json.created_at_date JalaliDate.to_jalali(comment.created_at)
        json.created_at_time comment.created_at.strftime("%H:%M")
    end
  end
