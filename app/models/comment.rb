class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  belongs_to :group, :class_name => "Group", :foreign_key => "commentable_id"
  belongs_to :event, :class_name => "Event", :foreign_key => "commentable_id"
  belongs_to :channel, :class_name => "Channel", :foreign_key => "commentable_id"
  belongs_to :note, :class_name => "Note", :foreign_key => "commentable_id"
  belongs_to :question, :class_name => "Question", :foreign_key => "commentable_id"
  belongs_to :answer, :class_name => "Answer", :foreign_key => "commentable_id"

end
