class SessionsController < ApplicationController

	def create
		@user = User.find_by(username: params[:username].downcase)
		if @user && @user.authenticate(params[:password])
			render "create.json.jbuilder", status: :accepted
		else
			render json: { error: "Could not find user for #{params[:username]} or wrong password." },
				status: :unauthorized
		end
	end

end