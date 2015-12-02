# Abstract App API
<hr>

Welcome to the Abstract App API documentation. Abstract allows creators to inspire and to be inspired!

The url params are called Path parameters

**Methods**

* [User Methods](#user-methods)
	* [Registration](#user-signup)
	* [Login] (#user-signin)
	* [Profile Setup] (#profile-setup)

	
##<a name="user-methods"></a>User Methods

###<a name="user-signup"></a>Sign Up

This request will create a new user in the system and return back an auth\_token back.  The auth\_token must be used for all subsequent requests (except for User Login).

**URL** /signup

**Method** POST

**Request**
    

| Form Params | Type           | Description  |
| ------------- |:-------------:|:----- |
| firstname | String | *(Required)* User's first name
| lastname | String | *(Required)* User's last name
| username | String | *(Required)* User's username
| email | String | ​*(Required)*​ Users email address, must follow the format text@text.text |
| password    | String      |  ​*(Required)*​  password for the user |


**Response**

If successful, you will receive:

    Status Code: 201 - Created
    
```json
{
  "firstname": "kaveh",
  "lastname": "vakili",
  "email": "kdvakili@gmail.com",
  "username": "kaveh",
  "auth_token": "e6790f536dd855d82afd1ca8841a00bb"
}         
```

If unsuccessful, you will receive:

    Status Code: 422 - Unprocessable Entity
    
```json
{
  "errors": [
    "Email has already been taken",
    "Username has already been taken"
  ]
}
```

###<a name="user-signin"></a>Sign In

This request will allow an existing user in the system to send their username and password and return back an auth\_token back.  The auth\_token must be used for all subsequent requests (except for User Registration).

**URL** /users

**Method** POST

**Request**
    
| Form Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| username | String | ​*(Required)*​ existing user's username |
| password | String |  ​*(Required)*​  password for the user |


**Response**

If successful, you will receive:

    Status Code: 202 - Accepted
    
```json
{
  "firstname": "sepehr",
  "lastname": "vakili",
  "email": "sdvakili@gmail.com",
  "username": "sepehr",
  "auth_token": "b83fe51a36fe825a12e394e3f8ad8016"
}    
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "error": "Could not find user for sepehr or wrong password."
}
```

