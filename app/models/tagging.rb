class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :question, :class_name => "Question", :foreign_key => "taggable_id"


end
