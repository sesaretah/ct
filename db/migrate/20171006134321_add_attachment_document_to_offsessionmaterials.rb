class AddAttachmentDocumentToOffsessionmaterials < ActiveRecord::Migration
  def self.up
    change_table :offsessionmaterials do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :offsessionmaterials, :document
  end
end
