class CommentsController < ApplicationController
	before_action :authenticate_user!, except: [:public, :index, :show]

	def create
		commentable = find_commentable
		@comment = commentable.comments.new(
				message: params[:message],
				user_id: current_user.id
			)
		if @comment.save
			render :create, status: :created
		else
			render json: { errors: @comment.errors.full_messages },
				status: :unprocessible_entity
		end
	end

	def show
		if Comment.exists?(params[:id])
			@comment = Comment.find(params[:id])
			render :show, status: :ok
		else
			render json: { errors: "Comment does not exist." }, status: :not_found
		end
	end

	def index
		commentable = find_commentable
	  @comments = commentable.comments
		render :index, status: :ok
	end

	def update
  	@comment = Comment.find(params[:id])
		if current_user.id == @comment.user_id
  		@comment.update(message: params[:message])
	  	render :update, status: :ok
		else
			render json: { errors: "User #{current_user.firstname} does not have access to this comment." }, status: :unauthorized
		end
	end	

	def destroy
		comment = Comment.find(params[:id])
		if current_user.id == comment.user_id
			comment.destroy
			render json: { message: "Comment has been deleted." }, status: :ok
		else
			render json: { errors: "User #{current_user.firstname} does not have access to this comment." }, status: :unauthorized
		end
	end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end