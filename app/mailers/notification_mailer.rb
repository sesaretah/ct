class NotificationMailer < ApplicationMailer
  default from: 'snadmin@ut.ac.ir'

  def digest(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
