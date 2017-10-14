class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :cas_authenticatable

  has_many :educations, dependent: :destroy
  has_many :honors, dependent: :destroy
  #has_many :researches, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_one :profile, dependent: :destroy

  has_many :send_messages, :class_name=>"Message", :foreign_key=>"sender_id", dependent: :destroy


  has_many :events, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :channels, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_one :blog, dependent: :destroy

  has_many :groupings, dependent: :destroy
  has_many :groups, :through => :groupings

  has_many :participations, dependent: :destroy
  has_many :events, :through => :participations

  has_many :involvements, dependent: :destroy
  has_many :channels, :through => :involvements
  #has_one :blog
  has_many :seekings, dependent: :destroy
  has_many :blogs, :through => :seekings

  has_many :partnerships, dependent: :destroy
  has_many :projects, :through => :partnerships

  has_many :assignments, dependent: :destroy
  has_many :tasks, :through => :assignments

  has_many :questions, dependent: :destroy
  has_many :preports, dependent: :destroy
  has_many :polls, dependent: :destroy

  has_many :followships, dependent: :destroy

  has_many :courses, dependent: :destroy

  has_many :visits, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", dependent: :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :contributions, dependent: :destroy
  has_many :researches, :through => :contributions

  has_many :memberships, dependent: :destroy
  has_many :labs, :through => :memberships

  has_many :grantings

  before_create :set_email
  def set_email
      self.email = self.username + '@ut.ac.ir'
  end

end
