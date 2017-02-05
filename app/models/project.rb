class Project < ActiveRecord::Base
  has_many :partnerships
  has_many :users, :through => :partnerships
  has_many :tasks
end
