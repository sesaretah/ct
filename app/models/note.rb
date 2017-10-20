class Note < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  def self.recent_week
    Note.where("created_at >= ?", 1.week.ago.utc).group("year(created_at)").group("month(created_at)").group("day(created_at)").count
  end
end
