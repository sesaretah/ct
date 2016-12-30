class Note < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
end
