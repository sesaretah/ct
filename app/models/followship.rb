class Followship < ActiveRecord::Base
  belongs_to :user
  belongs_to :followable, :polymorphic => true
  belongs_to :question, :class_name => "Question", :foreign_key => "followable_id"
  belongs_to :project, :class_name => "Project", :foreign_key => "followable_id"
  belongs_to :lab, :class_name => "Lab", :foreign_key => "followable_id"
end
