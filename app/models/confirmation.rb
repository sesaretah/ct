class Confirmation < ActiveRecord::Base
  belongs_to :confirmable, :polymorphic => true
  belongs_to :profile, :class_name => "Profile", :foreign_key => "confirmable_id"
  after_save :mail_confirmation

  def mail_confirmation
    if self.confrimation_stat != 1
    case self.confirmable_type
    when 'Profile'
      @profile =  Profile.find(self.confirmable_id)
      ConfirmationMailer.profile_email_validation(@profile, self).deliver
    end
  end
  end
end
