class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :votes, :as => :voteable, :dependent => :destroy
end
