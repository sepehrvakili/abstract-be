class Tagging < ActiveRecord::Base

	belongs_to :taggable, :polymorphic => true
  # adding dependent: :destroy would delete all tags even if they're being used by other posts
	belongs_to :tag

end
