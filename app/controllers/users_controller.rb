class UsersController < ApplicationController

	def create
		@user = User.new(user_params)
		if @user.save
			render "create.json.jbuilder", status: :created
		else
			render json: { errors: @user.errors.full_messages },
				status: :unprocessible_entity
		end
	end

	private

  def user_params
    params.permit(:firstname, :lastname, :username, :email, :password)
  end

end
