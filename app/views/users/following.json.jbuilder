json.page @page
json.page_count @following.total_pages
json.following do
  json.array! @following do |followed|
  	json.relationship_id Relationship.where(follower_id: @user.id, followed_id: followed.id).first.id
    json.user_id  followed.id
    json.username followed.username
    json.picture_thumb  Profile.find_by(user_id: followed.id).picture.url(:thumb)
    json.picture_medium  Profile.find_by(user_id: followed.id).picture.url(:medium)
    json.picture_large  Profile.find_by(user_id: followed.id).picture.url(:large)
  end
end