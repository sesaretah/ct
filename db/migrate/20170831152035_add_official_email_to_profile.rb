class AddOfficialEmailToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :official_email, :string
  end
end
