class Blog < ActiveRecord::Base
  has_many :seekings
  has_many :users, :through => :seekings
  has_many :notes
  after_create :set_admin

  def set_admin
    @seeking = {user_id: self.user_id, blog_id: self.id, role: 1}
    Seeking.create(@seeking)
  end
end
