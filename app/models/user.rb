class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :educations
  has_many :honors
  has_many :researches
  has_many :tags
  has_one :profile
  has_many :send_messages, :class_name=>"Message", :foreign_key=>"sender_id"
  has_many :received_messages, :class_name=>"Message", :foreign_key=>"recipient_id"
  has_many :events
  has_many :groups
  has_many :channels
  has_many :comments
  has_many :notes
end
