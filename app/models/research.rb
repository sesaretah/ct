class Research < ActiveRecord::Base
  has_attached_file :document
  validates_attachment :document, :content_type => {:content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}

  belongs_to :user
  has_many :rankings, :as => :rankable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

end
