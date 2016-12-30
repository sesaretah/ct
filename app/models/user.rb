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
  has_many :groupings
  has_many :groups, :through => :groupings

  has_many :participations
  has_many :events, :through => :participations

  has_many :involvements
  has_many :channels, :through => :involvements
  #has_one :blog
  has_many :seekings
  has_many :blogs, :through => :seekings
end
