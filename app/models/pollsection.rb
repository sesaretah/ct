class Pollsection < ActiveRecord::Base
  has_many :pollitems, dependent: :destroy
  belongs_to :poll
end
