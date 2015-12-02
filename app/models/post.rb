class Post < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :post_type
	has_attached_file :image, styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end
