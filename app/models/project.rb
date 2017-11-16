class Project < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "140x140>", :thumb => "35x35>", :large => "500x500>"  }, :default_url => "/assets/noimage-35-:style.jpg",  :processors => [:cropper]
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :ratio, :caller
  after_update :reprocess_avatar, :if => :cropping?

  has_many :partnerships, :dependent => :destroy
  has_many :users, :through => :partnerships
  has_many :tasks, :dependent => :destroy
  has_many :followships, :as => :followable, :dependent => :destroy
  has_many :taggings, :as => :taggable, :dependent => :destroy

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end

  private

  def reprocess_avatar
    avatar.assign(avatar)
    avatar.save
  end
end
