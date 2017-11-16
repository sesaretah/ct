class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :question, :class_name => "Question", :foreign_key => "taggable_id"
  belongs_to :channel, :class_name => "Channel", :foreign_key => "taggable_id"
  belongs_to :group, :class_name => "Group", :foreign_key => "taggable_id"
  belongs_to :event, :class_name => "Event", :foreign_key => "taggable_id"
  belongs_to :project, :class_name => "Project", :foreign_key => "taggable_id"
  belongs_to :course, :class_name => "Course", :foreign_key => "taggable_id"
  belongs_to :lab, :class_name => "Lab", :foreign_key => "taggable_id"
  belongs_to :research, :class_name => "Research", :foreign_key => "taggable_id"
  belongs_to :poll, :class_name => "Poll", :foreign_key => "taggable_id"


end
