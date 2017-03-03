class AddAttachmentDocumentToResearches < ActiveRecord::Migration
  def self.up
    change_table :researches do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :researches, :document
  end
end
