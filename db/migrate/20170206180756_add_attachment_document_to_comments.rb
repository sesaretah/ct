class AddAttachmentDocumentToComments < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :comments, :document
  end
end
