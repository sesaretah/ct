class Offsession < ActiveRecord::Base
  belongs_to :offering
  has_many :offsessionmaterials, dependent: :destroy
end
