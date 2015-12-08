class User < ActiveRecord::Base

	has_one :profile, dependent: :destroy
	has_many :posts, dependent: :destroy
	has_many :likes, dependent: :destroy

	has_many :liked_posts, through: :likes, source: :likeable, source_type: "Post"

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

end
	