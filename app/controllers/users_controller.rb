class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:create, :login, :followers, :following]

	def create
		@user = User.new(user_params)
		if @user.save
			render "create.json.jbuilder", status: :created
		else
			render json: { errors: @user.errors.full_messages },
				status: :unprocessible_entity
		end
	end

	def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      render :login, status: :ok
    else
      render json: { error: "Could not find user for #{params[:username]} or wrong password." },
        status: :unauthorized
    end
	end

	def show
		if User.exists?(params[:id])
			@profile = Profile.find_by(user_id: params[:id])
			@profile = build_profiles([@profile])
    	render :show, status: :ok
    else
    	render json: { errors: "Profile does not exist." },
    		status: :not_found
    end
	end

	def index
		@page = params[:page] || 1
		@profiles = Profile.all.page(@page).per(20)
		@total_pages = @profiles.total_pages
		@profiles = build_profiles(@profiles)
		render :index, status: :ok
	end

	def followers
		@page = params[:page] || 1
		user = User.find(params[:id])
		@followers = user.followers.page(@page).per(20)
		render :followers, status: :ok
	end

	def following
		@page = params[:page] || 1
		@user = User.find(params[:id])
		@following = @user.following.page(@page).per(20)
		render :following, status: :ok
	end

	# try to fix it later:
	# def destroy
	# 	user = User.find(params[:id])
	# 	if current_user.id == user.id
	# 		user.destroy
	# 		render json: { message: "#{current_user.firstname}'s account & profile have been deleted." }, status: :ok
	# 	else
	# 		render json: { message: "User #{current_user.firstname} does not have access to this user." }, status: :unauthorized
	# 	end
	# end

	private

  def user_params
    params.permit(:firstname, :lastname, :username, :email, :password)
  end

end
