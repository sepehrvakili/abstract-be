class Tag < ActiveRecord::Base

  has_many :taggings
  has_many :posts, through: :taggings
 	has_many :profiles, through: :taggings

	validates_presence_of :phrase

end
