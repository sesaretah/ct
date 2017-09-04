class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :research
end
