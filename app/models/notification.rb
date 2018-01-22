class Notification < ActiveRecord::Base
  include Fcm
  after_save :mail_notification
  def mail_notification

    case self.notifiable_type
    when 'Comment'
      case self.notifiee_type
      when 'Group'
        @comment = Comment.find(notifiable_id)
        @commenter = "#{@comment.user.profile.name} " + "#{@comment.user.profile.surename}"
        @user_ids = Grouping.where(group_id: self.notfiee_id, role:[1,3]).pluck(:user_id)
        send_fcm(@user_ids, @commenter , @comment.content.truncate(30), @comment.commentable_type, @comment.commentable_id)
      end

    when 'Involvement'
      @admins = Involvement.where(role: 1, channel_id: self.notfiee_id)
      @involvement = Involvement.find(self.notifiable_id)
      for admin in @admins
        @user = admin.user
        @nsadmin = NotificationSetting.where(user_id: @user.id).first
        if @nsadmin.involvement == 1
          NotificationMailer.involvement_admin_digest(@user, @involvement).deliver
        end
      end
      @ns = NotificationSetting.where(user_id: @involvement.user.id).first
      if @ns.involvement == 1
        NotificationMailer.involvement_added_user_digest(@involvement.user, @involvement).deliver
      end
    when 'Grouping'
      @admins = Grouping.where(role: 1, group_id: self.notfiee_id)
      @grouping = Grouping.find(self.notifiable_id)
      for admin in @admins
        @user = admin.user
        @gradmin = NotificationSetting.where(user_id: @user.id).first
        if @gradmin.grouping == 1
          NotificationMailer.grouping_admin_digest(@user, @grouping).deliver
        end
      end
      @gr = NotificationSetting.where(user_id: @grouping.user.id).first
      if @gr.grouping == 1
        NotificationMailer.grouping_added_user_digest(@grouping.user, @grouping).deliver
      end
    end
  end
end
