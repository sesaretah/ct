class AddAttachmentAvatarToComments < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :comments, :avatar
  end
end
