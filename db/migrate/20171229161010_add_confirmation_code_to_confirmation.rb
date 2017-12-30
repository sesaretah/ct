class AddConfirmationCodeToConfirmation < ActiveRecord::Migration
  def change
    add_column :confirmations, :confirmation_code, :text
  end
end
