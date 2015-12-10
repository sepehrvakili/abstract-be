json.page @page
json.page_count @followers.total_pages
json.followers do
  json.array! @followers do |follower|
    json.user_id  follower.id
    json.username follower.username
    json.picture_thumb  Profile.find_by(user_id: follower.id).picture.url(:thumb)
    json.picture_medium  Profile.find_by(user_id: follower.id).picture.url(:medium)
    json.picture_large  Profile.find_by(user_id: follower.id).picture.url(:large)
  end
end