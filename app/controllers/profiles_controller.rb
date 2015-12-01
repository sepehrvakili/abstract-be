class ProfilesController < ApplicationController
	before_action :authenticate_user!, except: [:index]

	def create
		@profile = current_user.build_profile(profile_params)
		if @profile.save
			render :create, status: :created
		else
			render json: { errors: @profile.errors.full_messages },
				status: :unprocessable_entity
		end
	end

	def show
		@profile = Profile.find_by(user_id: current_user.id)
    render :show, status: :ok
	end

	def index

	end

	def destroy
		
	end

	private

	def profile_params
    params.require(:profile).permit(:bio, :website, :location, :picture)
  end

end
