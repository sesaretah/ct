class CreatePrivacypolicies < ActiveRecord::Migration
  def change
    create_table :privacypolicies do |t|
      t.integer :profile_fathername
      t.integer :profile_sex
      t.integer :profile_birthdate
      t.integer :profile_ssn
      t.integer :profile_phonenumber
      t.integer :profile_mobilenumber
      t.integer :education_all
      t.integer :research_all
      t.integer :honor_all
      t.integer :tag_all
      t.integer :followers_all
      t.integer :followess_all

      t.timestamps null: false
    end
  end
end
