class Grouping < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  after_save :set_notification
  def set_notification
      @notification = Notification.create(user_id: self.user.id, notifiable_type: 'Grouping', notifiable_id: self.id, notifiee_type: 'Group', notfiee_id: self.group.id)
  end
end
