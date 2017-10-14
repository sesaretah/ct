class CreateAccesscontrols < ActiveRecord::Migration
  def change
    create_table :accesscontrols do |t|
      t.integer :role_id
      t.integer :create_blog
      t.integer :view_blogs
      t.integer :comment_on_blogs
      t.integer :search_blogs
      t.integer :create_channel
      t.integer :view_channels
      t.integer :join_channels
      t.integer :search_channels
      t.integer :create_group
      t.integer :view_groups
      t.integer :join_groups
      t.integer :comment_on_groups
      t.integer :search_groups
      t.integer :create_event
      t.integer :view_events
      t.integer :join_events
      t.integer :comment_on_events
      t.integer :search_events
      t.integer :view_questions
      t.integer :comment_on_questions
      t.integer :ask_questions
      t.integer :answer_questions
      t.integer :comment_on_answers
      t.integer :create_project
      t.integer :view_projects
      t.integer :search_projects
      t.integer :create_course
      t.integer :view_courses
      t.integer :search_courses
      t.integer :create_lab
      t.integer :view_labs
      t.integer :search_labs
      t.integer :create_good
      t.integer :view_goods
      t.integer :search_goods
      t.integer :create_research
      t.integer :view_researches
      t.integer :search_researches
      t.integer :comment_on_researches
      t.integer :rate_researches
      t.integer :create_poll
      t.integer :take_poll
      t.integer :view_profiles
      t.integer :search_profiles

      t.timestamps null: false
    end
  end
end
