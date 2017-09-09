class ConvertDatabaseToUtf8mb4 < ActiveRecord::Migration
  def change
   execute "ALTER TABLE comments CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY content TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
  end
end
