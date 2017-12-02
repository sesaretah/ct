class AddDigestEmailToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :digest_email, :string
  end
end
