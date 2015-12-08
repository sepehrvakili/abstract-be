class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :json_defaults

  protected

  def current_user
  	token = request.headers['Auth-Token']
  	token && User.find_by(auth_token: token)
  end

  def authenticate_user!
  	unless current_user
  		token = request.headers['Auth-Token']
  		render json: { error: "Could not authenticate with token: '#{token}'"},
  			status: :unauthorized
  	end
  end

  def json_defaults
  	request.format = :json unless params[:format]
  end

  private
  def build_profiles(profiles)
    profiles.map { |profile|
      {
        id: profile.user_id,
        bio: profile.bio,
        website: profile.website,
        location: profile.location,
        picture_thumb: profile.picture.url(:thumb),
        picture_medium: profile.picture.url(:medium),
        picture_large: profile.picture.url(:large),
        profile_id: profile.id,
        username: User.find(profile.user_id).username,
        tags: profile.tag_phrases
      }
    }
  end

  def build_posts(posts)
    posts.map { |post| 
      {
        id: post.id,
        post_type: post.post_type,
        title: post.title,
        url: post.url,
        description: post.description,
        status: post.status,
        quote: post.quote,
        image_thumb: post.image.url(:thumb),
        image_medium: post.image.url(:medium),
        image_large: post.image.url(:large),
        user_id: post.user_id,
        username: User.find(post.user_id).username,
        likes_count: post.likes.count,
        tags: post.tag_phrases,
        created_at: post.created_at,
        updated_at: post.updated_at
      }
    }
  end

end
