class ProfilesController < ApplicationController
	before_action :authenticate_user!

	def create
		@profile = current_user.build_profile(profile_params)
		if @profile.save
			@profile = build_profiles([@profile])
			render :create, status: :created
		else
			render json: { errors: @profile.errors.full_messages },
				status: :unprocessable_entity
		end
	end

	private

	def profile_params
    params.require(:profile).permit(:bio, :website, :location, :picture)
  end

end
