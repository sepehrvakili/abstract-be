json.page @page
json.page_count @users.total_pages
json.users do
	json.array! @users do |user|
		profile = Profile.find_by(user_id: user.id)
		json.id user.id
		json.username user.username
		json.bio profile.bio
		json.website profile.website
		json.location profile.location
		json.picture_thumb profile.picture.url(:thumb)
		json.picture_medium profile.picture.url(:medium)
		json.picture_large profile.picture.url(:large)
		json.profile_id profile.id
		json.tags profile.tag_phrases
	end
end