class Profile < ActiveRecord::Base

	belongs_to :user

	validates_presence_of :picture, :bio, :website, :location
	has_attached_file :picture, styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>" }
	validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

end
