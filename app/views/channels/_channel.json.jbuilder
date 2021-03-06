json.extract! channel, :id, :name, :description, :created_at, :updated_at
json.url channel_url(channel, format: :json)
json.image root_url + url_for(channel.avatar(:thumb))

json.admins do
  json.array!(channel.involvements.where(role: 1)) do |inv|
    @msinv = Mobilesetting.where(user_id: inv.user_id).first
    if !@msinv.blank?
      json.uuid @msinv.uuid
    end
  end
end

json.comments do
    json.array!(channel.comments.last(5)) do |comment|
        json.id comment.id
        json.commentable_type  comment.commentable_type
        json.commentable_id comment.commentable_id
        json.content comment.content
        json.image root_url + url_for(comment.user.profile.avatar(:thumb))
        json.avatar comment.avatar(:medium)
        json.document comment.document.url
        @name = comment.user.profile.name + ' ' + comment.user.profile.surename
        json.owner @name.truncate(13)
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
