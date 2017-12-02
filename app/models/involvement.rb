class Involvement < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
  after_save :set_notification
  def set_notification
      @notification = Notification.create(user_id: self.user.id, notifiable_type: 'Involvement', notifiable_id: self.id, notifiee_type: 'Channel', notfiee_id: self.channel.id)
  end
end
