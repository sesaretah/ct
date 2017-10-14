class Role < ActiveRecord::Base
  has_many :grantings
end
