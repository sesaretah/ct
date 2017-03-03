class Ranking < ActiveRecord::Base
  belongs_to :user
  belongs_to :rankable, :polymorphic => true
  belongs_to :research, :class_name => "Research", :foreign_key => "rankable_id"
end
