class Profile < ActiveRecord::Base

	belongs_to :user
	has_many :taggings, as: :taggable
	has_many :tags, through: :taggings, dependent: :destroy

	has_attached_file :picture, styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>" }

	validates_presence_of :picture, :bio, :website, :location
	validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

	def tag_phrases
    self.tags.map(&:phrase).join(", ")
  end

  def tag_phrases=(inputted_phrases)
    tag_models = inputted_phrases.split(", ").map { |phrase| Tag.find_or_create_by(phrase: phrase) }
    self.tags = tag_models
  end

end
