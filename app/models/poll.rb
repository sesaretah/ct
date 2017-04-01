class Poll < ActiveRecord::Base
  has_many :pollitems
  has_many :pollsections
  belongs_to :user
end
