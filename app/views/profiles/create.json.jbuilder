json.profile do
	json.id @profile.id
	json.bio @profile.bio
	json.website @profile.website
	json.location @profile.location
	json.picture_thumb @profile.picture.url(:thumb)
	json.picture_medium @profile.picture.url(:medium)
	json.picture_large @profile.picture.url(:large)
	json.user_id @profile.user_id
	json.username User.find(@profile.user_id).username
	json.tags @profile.tag_phrases
end