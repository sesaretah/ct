class Poll < ActiveRecord::Base
  has_many :pollitems
  has_many :pollsections
  belongs_to :user
  has_many :taggings, :as => :taggable, :dependent => :destroy
end
