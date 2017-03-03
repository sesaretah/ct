class AddAttachmentAvatarToLabs < ActiveRecord::Migration
  def self.up
    change_table :labs do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :labs, :avatar
  end
end
