class Offering < ActiveRecord::Base
  belongs_to :course
  has_many :offsessions, dependent: :destroy
end
