class Visit < ActiveRecord::Base
  belongs_to :user
  belongs_to :visitable, :polymorphic => true
  belongs_to :question, :class_name => "Question", :foreign_key => "visitable_id"
  belongs_to :project, :class_name => "Project", :foreign_key => "visitable_id"
  belongs_to :lab, :class_name => "Lab", :foreign_key => "visitable_id"
  belongs_to :research, :class_name => "Research", :foreign_key => "visitable_id"

  belongs_to :channel, :class_name => "Channel", :foreign_key => "visitable_id"
  belongs_to :group, :class_name => "Group", :foreign_key => "visitable_id"
  belongs_to :event, :class_name => "Event", :foreign_key => "visitable_id"
  belongs_to :blog, :class_name => "Blog", :foreign_key => "visitable_id"
end
