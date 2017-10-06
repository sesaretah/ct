class Offsessionmaterial < ActiveRecord::Base
    belongs_to :offsession
    has_attached_file :document
    validates_attachment :document, :content_type => {:content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}

end
