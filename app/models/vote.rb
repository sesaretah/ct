class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, :polymorphic => true
  belongs_to :question, :class_name => "Question", :foreign_key => "voteable_id"
  belongs_to :answer, :class_name => "Answer", :foreign_key => "voteable_id"
end
