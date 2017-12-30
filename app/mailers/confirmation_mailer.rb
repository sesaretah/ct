class ConfirmationMailer < ApplicationMailer
  default from: 'snadmin@ut.ac.ir'

  def profile_email_validation(profile, confirmation)
    @confirmation = confirmation
    @profile = profile
    mail(to: @profile.digest_email, subject: t(:confirmation_request))
  end
end
