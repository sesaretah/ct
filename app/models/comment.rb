class Comment < ActiveRecord::Base
  has_attached_file :document
  validates_attachment :document, :content_type => {:content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}

  has_attached_file :avatar, :styles => { :medium => "140x140>", :thumb => "35x35>", :large => "500x500>"  }, :default_url => "/assets/noimage-:style.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  belongs_to :group, :class_name => "Group", :foreign_key => "commentable_id"
  belongs_to :event, :class_name => "Event", :foreign_key => "commentable_id"
  belongs_to :channel, :class_name => "Channel", :foreign_key => "commentable_id"
  belongs_to :note, :class_name => "Note", :foreign_key => "commentable_id"
  belongs_to :question, :class_name => "Question", :foreign_key => "commentable_id"
  belongs_to :answer, :class_name => "Answer", :foreign_key => "commentable_id"
  belongs_to :research, :class_name => "Research", :foreign_key => "commentable_id"

end
