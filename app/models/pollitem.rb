class Pollitem < ActiveRecord::Base
  belongs_to :poll
  belongs_to :pollsection
end
