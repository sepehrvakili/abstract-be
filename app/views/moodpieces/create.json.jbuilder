json.moodpiece do
	json.id @moodpiece.id
	json.div_id @moodpiece.div_id
	json.color @moodpiece.color
	json.image @moodpiece.image.url
	json.post_id @moodpiece.post_id
	json.image @moodpiece.image.url
	json.created_at @moodpiece.created_at
	json.updated_at @moodpiece.updated_at
end
