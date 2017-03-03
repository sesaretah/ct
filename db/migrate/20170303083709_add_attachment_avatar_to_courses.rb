class AddAttachmentAvatarToCourses < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :courses, :avatar
  end
end
