class MoodpiecesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def create
		post = Post.find(params[:post_id])
		@moodpiece = post.moodpieces.new(moodpiece_params)
		if @moodpiece.save
			render :create, status: :created
		else
			render json: { errors: @moodpiece.errors.full_messages },
				status: :unprocessible_entity
		end
	end

	def update
		post = Post.find(params[:post_id])
		if current_user.id == post.user_id
			@moodpiece = Moodpiece.find(params[:id])
			@moodpiece.update(moodpiece_params)
			render :update, status: :ok
		else
			render json: { message: "#{current_user.firstname} does not have access to this moodpiece." }, status: :unauthorized
		end
	end

	def destroy
		post = Post.find(params[:post_id])
		if current_user.id == post.user_id
			moodpiece = Moodpiece.find(params[:id])
			moodpiece.destroy
			render json: { message: "Moodpiece has been removed." }, status: :ok
		else
			render json: { message: "#{current_user.firstname} does not have access to this moodpiece." }, status: :unauthorized
		end
	end

	private
  def moodpiece_params
    params.permit(:div_id, :color, :image)
  end

end