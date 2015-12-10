class Relationship < ActiveRecord::Base

	has_many :following_posts, through: :followed, source: :posts

	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"
	validates_presence_of :follower_id, :followed_id

end
