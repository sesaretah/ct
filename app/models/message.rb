class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  has_many :recipients, :dependent => :destroy
  has_many :users, :through => :recipients
end
