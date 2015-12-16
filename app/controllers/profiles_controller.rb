class ProfilesController < ApplicationController
	before_action :authenticate_user!

	def create
		if current_user.profile.present?
			render json: { errors: "A profile already exists for #{current_user.firstname}."}, status: :unprocessable_entity
		else
			@profile = current_user.build_profile(profile_params)
			if @profile.save
				render :create, status: :created
			else
				render json: { errors: @profile.errors.full_messages },
					status: :unprocessable_entity
			end
		end
	end

	private

	def profile_params
    params.permit(:bio, :website, :location, :picture, :tag_phrases)
  end

end
