class AddAttachmentAvatarToGoods < ActiveRecord::Migration
  def self.up
    change_table :goods do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :goods, :avatar
  end
end
