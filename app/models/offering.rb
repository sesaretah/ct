class Offering < ActiveRecord::Base
  belongs_to :course
  has_many :offsessions, dependent: :destroy
  has_many :followships, :as => :followable, :dependent => :destroy
end
