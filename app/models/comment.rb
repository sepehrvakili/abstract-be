class Comment < ActiveRecord::Base

	belongs_to :commentable, :polymorphic => true
	belongs_to :post

	validates_presence_of :message

end
