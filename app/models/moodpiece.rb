class Moodpiece < ActiveRecord::Base
  
  belongs_to :post

  validates_presence_of :div_id

	has_attached_file :image
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end
