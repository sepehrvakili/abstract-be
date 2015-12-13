class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:create, :login, :followers, :following]

	def create
		@user = User.new(user_params)
		if @user.save
			render :create, status: :created
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
			@user = User.find(params[:id])
    	render :show, status: :ok
    else
    	render json: { errors: "User does not exist." },
    		status: :not_found
    end
	end

	def index
		@page = params[:page] || 1
		@users = User.all.page(@page).per(20)
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

	def destroy
		user = User.find(params[:id])
		if current_user.id == user.id
			firstname = user.firstname
			user.destroy
			render json: { message: "#{firstname}'s account has been deleted." }, status: :ok
		else	
			render json: { message: "#{current_user.firstname} is not the rightful owner of this account." }, status: :unauthorized
		end
	end

	private

  def user_params
    params.permit(:firstname, :lastname, :username, :email, :password)
  end

end
