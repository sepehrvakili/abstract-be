class RelationshipsController < ApplicationController
	before_action :authenticate_user!

	def create
		if params[:followed_id].present?
			user = User.find(params[:followed_id])
			current_user.follow(user)
			render json: { message: "You are now following #{user.username}." }, status: :created
		else
			render json: { errors: "You must provide a 'followed_id'." }, status: :unprocessible_entity
		end
	end

	def destroy
		user = Relationship.find(params[:id]).followed
		current_user.unfollow(user)
		render json: { message: "You are no longer following #{user.username}." }, status: :ok
	end

end