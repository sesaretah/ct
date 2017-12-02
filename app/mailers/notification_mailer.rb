class NotificationMailer < ApplicationMailer
  default from: 'snadmin@ut.ac.ir'

  def digest(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def involvement_admin_digest(user, involvement)
    @user = user
    @involvement = involvement
    mail(to: @user.profile.digest_email, subject: 'Update on Your Channel')
  end

  def involvement_added_user_digest(user, involvement)
    @user = user
    @involvement = involvement
    mail(to: @user.profile.digest_email, subject: 'You Are Added To A Channel')
  end

  def grouping_admin_digest(user, grouping)
    @user = user
    @grouping = grouping
    mail(to: @user.profile.digest_email, subject: 'Update on Your Group')
  end

  def grouping_added_user_digest(user, grouping)
    @user = user
    @grouping = grouping
    mail(to: @user.profile.digest_email, subject: 'You Are Added To A Group')
  end
end
