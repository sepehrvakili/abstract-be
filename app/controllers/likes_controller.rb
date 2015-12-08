class LikesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def create
    likeable = find_likeable
    @like = current_user.likes.build(likeable: likeable)

    if @like.save
      render json: { message: "Item has been liked." }, status: :created
    else
      render json: { errors: @like.errors.full_messages },
				status: :unprocessible_entity
    end
	end

	def index
		@page = params[:page] || 1
		user = User.find(params[:user_id])
		if params[:likeable_type].present?
			case params[:likeable_type].downcase
			when 'post'
				@likes = user.liked_posts.page(@page).per(20)
			else
				@likes = { error: "Not a valid likeable type: '#{params[:likeable_type]}'" }
			end
			render :index, status: :ok
		else 
      render json: { errors: "You must provide a likeable_type path param." },
				status: :unprocessible_entity
		end
	end

	def destroy
		likeable = find_likeable
		if current_user.likes.exists?(likeable: likeable)
			like = current_user.likes.find_by(likeable: likeable)
			like.destroy
			render json: { message: "#{current_user.firstname}'s like has been removed." }, status: :ok
		else
			render json: { errors: "#{current_user.firstname} does not have access to this like." }, status: :unauthorized
		end
	end

	private
  def find_likeable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end