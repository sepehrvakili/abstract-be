class Post < ActiveRecord::Base

	belongs_to :user

	has_many :moodpieces, dependent: :destroy

	has_many :taggings, as: :taggable
	has_many :tags, through: :taggings, dependent: :destroy
	
	has_many :comments, as: :commentable, dependent: :destroy
	
	has_many :likes, as: :likeable, dependent: :destroy
  has_many :fans, through: :likes, source: :user

	has_attached_file :image, styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>" }

	validates_presence_of :post_type
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def tag_phrases
    self.tags.map(&:phrase).join(", ")
  end

  def tag_phrases=(inputted_phrases)
    tag_models = inputted_phrases.split(", ").map { |phrase| Tag.find_or_create_by(phrase: phrase) }
    self.tags = tag_models
  end

end
