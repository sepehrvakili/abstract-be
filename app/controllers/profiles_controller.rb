class ProfilesController < ApplicationController
	before_action :authenticate_user!, except: [:index]

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

	def show
		if Profile.exists?(params[:id])
			@profile = Profile.find(params[:id])
			@profile = build_profiles([@profile])
    	render :show, status: :ok
    else
    	render json: { errors: "Profile does not exist." },
    		status: :not_found
    end
	end

	def public
		@page = params[:page] || 1
		@profiles = Profile.all.page(@page).per(20)
		@total_pages = @profiles.total_pages
		@profiles = build_profiles(@profiles)
		render :public, status: :ok
	end

	def destroy
		profile = Profile.find(params[:id])
		if current_user.id == profile.user_id
			profile.destroy
			render json: { message: "#{current_user.firstname}'s profile has been deleted." }, status: :ok
		else
			render json: { message: "User #{current_user.firstname} does not have access to this profile." }, status: :unauthorized
		end
	end

	private

	def profile_params
    params.require(:profile).permit(:bio, :website, :location, :picture)
  end

  def build_profiles(profiles)
  	profiles.map{ |profile|
  		{
  			id: profile.id,
  			bio: profile.bio,
  			website: profile.website,
  			location: profile.location,
  			picture_thumb: profile.picture.url(:thumb),
  			picture_medium: profile.picture.url(:medium),
  			picture_large: profile.picture.url(:large),
  			user_id: profile.user_id,
  			username: User.find(profile.user_id).username
  		}
  	}
  end

end
