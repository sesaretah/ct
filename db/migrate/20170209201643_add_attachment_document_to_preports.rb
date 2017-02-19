class AddAttachmentDocumentToPreports < ActiveRecord::Migration
  def self.up
    change_table :preports do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :preports, :document
  end
end
