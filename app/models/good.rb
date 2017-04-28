class Good < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "250x250>", :thumb => "85x85>", :large => "500x500>"  },
  :default_url => "/assets/noimage-:style.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  belongs_to :sub_category
  belongs_to :user
end
