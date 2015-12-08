json.page @page
json.page_count @posts.total_pages
json.posts do
	json.array! @posts do |post|
		json.post do
		  json.id post.id
		  json.post_type post.post_type
		  json.title post.title
		  json.url post.url
		  json.description post.description
		  json.status post.status
		  json.quote post.quote
		  json.image_thumb post.image.url(:thumb)
		  json.image_medium post.image.url(:medium)
		  json.image_large post.image.url(:large)
		  json.user_id post.user_id
		  json.username User.find(post.user_id).username
		  json.likes_count post.likes.count
		  json.tags post.tag_phrases
		  json.created_at post.created_at
		  json.updated_at post.updated_at
		  json.moodboard_css_class post.moodboard_css_class
		  json.moodpieces do
			  json.array! post.moodpieces do |moodpiece|
			  	json.id moodpiece.id
			  	json.div_id moodpiece.div_id
			  	json.color moodpiece.color
			  	json.image moodpiece.image.url
			  end
			end
		  json.comments do
		  	json.array! post.comments do |comment|
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