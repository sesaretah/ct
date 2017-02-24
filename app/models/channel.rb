class Channel < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "140x140>", :thumb => "35x35>", :large => "500x500>"  }, :default_url => "/assets/noimage-:style.jpg",  :processors => [:cropper]
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :ratio, :caller
  after_update :reprocess_avatar, :if => :cropping?

  has_many :involvements, dependent: :destroy
  has_many :users, :through => :involvements, dependent: :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  after_create :set_admin

  def set_admin
    @involvement = {user_id: self.user_id, channel_id: self.id, role: 1}
    Involvement.create(@involvement)
  end

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
