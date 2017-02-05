class Task < ActiveRecord::Base
  has_many :assignments, dependent: :destroy
  has_many :users, :through => :assignments
  belongs_to :project
end
