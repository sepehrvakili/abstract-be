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
  profiles.map{ |profile|
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

end
