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

	private
  def moodpiece_params
    params.permit(:div_id, :color, :image)
  end

end