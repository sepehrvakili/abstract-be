class Like < ActiveRecord::Base

	belongs_to :likeable, :polymorphic => true
  belongs_to :user

  validates_presence_of :user, :likeable

  #This will keep a user from liking something more than once
  validates_uniqueness_of :user_id, scope: [:likeable_id, :likeable_type], message: 'can only like an item once.'

end
