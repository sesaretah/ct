class AddAttachmentAvatarToChannels < ActiveRecord::Migration
  def self.up
    change_table :channels do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :channels, :avatar
  end
end
