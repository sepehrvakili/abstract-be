class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:public, :index, :show]

	def create
		@post = current_user.posts.new(post_params)
		if @post.save
			@post = build_posts([@post])
			render :create, status: :created
		else
			render json: { errors: @post.errors.full_messages },
				status: :unprocessible_entity
		end
	end

	def show
		if Post.exists?(params[:id])
			@post = Post.find(params[:id])
			@post = build_posts([@post])
			render :show, status: :ok
		else
			render json: { errors: "Post not found." }, status: :not_found
		end
	end

	def update
  	@post = Post.find(params[:id])
		if current_user.id == @post.user_id
  		@post.update(post_params)
  		@post = build_posts([@post])
	  	render :update, status: :ok
		else
			render json: { message: "User #{current_user.firstname} does not have access to this post." }, status: :unauthorized
		end
	end	

	def destroy
		post = Post.find(params[:id])
		if current_user.id == post.user_id
			post.destroy
			render json: { message: "#{post.title} has been deleted." }, status: :ok
		else
			render json: { message: "User #{current_user.firstname} does not have access to this post." }, status: :unauthorized
		end
	end

	def index
		@page = params[:page] || 1
		@posts = Post.where(user_id: params[:user_id]).page(@page).per(12)
		@total_pages = @posts.total_pages
		@posts = build_posts(@posts)
		render :index, status: :ok
	end

	def public
		@page = params[:page] || 1
		@posts = Post.all.page(@page).per(20)
		@total_pages = @posts.total_pages
		@posts = build_posts(@posts)
		render :index, status: :ok
	end

	private
  def post_params
    params.permit(:post_type, :title, :url, :description, :status, :quote, :image, :tag_phrases)
  end

end