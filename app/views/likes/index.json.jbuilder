json.page @page
json.page_count @likes.total_pages
json.likes do
	json.array! @likes do |like|
		json.like do
		  json.id like.id
		  json.post_type like.post_type
		  json.title like.title
		  json.url like.url
		  json.description like.description
		  json.status like.status
		  json.quote like.quote
		  json.image_thumb like.image.url(:thumb)
		  json.image_medium like.image.url(:medium)
		  json.image_large like.image.url(:large)
		  json.user_id like.user_id
		  json.username User.find(like.user_id).username
		  json.likes_count like.likes.count
		  json.tags like.tag_phrases
		  json.created_at like.created_at
		  json.updated_at like.updated_at
		  json.moodboard_css_class like.moodboard_css_class
		  json.moodpieces do
			  json.array! like.moodpieces do |moodpiece|
			  	json.id moodpiece.id
			  	json.div_id moodpiece.div_id
			  	json.color moodpiece.color
			  	json.image moodpiece.image.url
			  end
			end
		  json.comments do
		  	json.array! like.comments do |comment|
		  		json.id comment.id
		  		json.message comment.message
		  		json.created_at comment.created_at
		  		json.updated_at comment.updated_at
		  		json.user_id comment.user_id
		  		json.username User.find(comment.user_id).username
		  		json.picture Profile.find_by(user_id: comment.user_id).picture.url(:thumb)
		  	end
		  end
		end
	end
end