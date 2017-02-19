class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :votes, :as => :voteable, :dependent => :destroy
end
