class User < ActiveRecord::Base

	has_one :profile, dependent: :destroy
	has_many :posts, dependent: :destroy
	has_many :likes, dependent: :destroy

	has_many :liked_posts, through: :likes, source: :likeable, source_type: "Post"

	has_many :active_relationships, 	class_name: 	"Relationship",
																		foreign_key: 	"follower_id",
																		dependent: 		:destroy
	has_many :passive_relationships, 	class_name: 	"Relationship",
																		foreign_key: 	"followed_id",
																		dependent: 		:destroy
	has_many :following, through: :active_relationships, 	source: :followed
	has_many :followers, through: :passive_relationships, source: :follower

	has_many :following_posts, through: :active_relationships

	has_secure_password

	before_validation :ensure_auth_token!

	validates_presence_of :username, :firstname, :lastname, :auth_token
	validates_uniqueness_of :email, :username, :auth_token
	validates_format_of :email, with: /.+@.+\..+/

	def ensure_auth_token!
		if self.auth_token.blank?
			self.auth_token = User.generate_token
		end
	end

	def self.generate_token
		token = SecureRandom.hex
		while User.exists?(auth_token: token)
			token = SecureRandom.hex
		end
		token
	end

	# Follows a user.
	def follow(other_user)
		active_relationships.create(followed_id: other_user.id)
	end

	# Unfollows a user.
	def unfollow(other_user)
		active_relationships.find_by(followed_id: other_user.id).destroy
	end

	# Returns true if the current user is returning the other user.
	def following?(other_user)
		following.include?(other_user)
	end

end
