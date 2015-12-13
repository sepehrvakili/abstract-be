json.user do
	json.id @user.id
	json.firstname @user.firstname
	json.lastname @user.lastname
	json.username @user.username
	json.email @user.email
	json.auth_token @user.auth_token
	json.created_at @user.created_at
	json.updated_at @user.updated_at
end