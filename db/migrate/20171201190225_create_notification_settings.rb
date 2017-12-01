class CreateNotificationSettings < ActiveRecord::Migration
  def change
    create_table :notification_settings do |t|
      t.integer :user_id
      t.integer :channel_updates
      t.integer :involvement
      t.integer :blog_updates
      t.integer :group_updates
      t.integer :grouping
      t.integer :event_updates
      t.integer :participation
      t.integer :question_updates
      t.integer :question_comments
      t.integer :answers_comments
      t.integer :project_task
      t.integer :partnership
      t.integer :offsession
      t.integer :membership
      t.integer :announcement
      t.integer :contribution
      t.integer :research_ranking
      t.integer :research_comments
      t.integer :poll
      t.integer :messages

      t.timestamps null: false
    end
  end
end
