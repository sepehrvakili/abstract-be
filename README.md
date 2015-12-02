# Abstract App API
<hr>

Welcome to the Abstract App API documentation. Abstract allows creators to inspire and to be inspired!

The url params are called Path parameters

**Methods**

* [User Methods](#user-methods)
  * [Registration](#user-registration)
  * [Login](#user-login)
  * [Deletion](#user-delete)
  * [Profile Retrieval](#user-retrieve)
  * [All Profiles Retrieval](#users-retrieve)

* [Profile Methods](#profile-methods)
  * [Creation](#profile-creation)


##<a name="user-methods"></a>User Methods

###<a name="user-registeration"></a>Registration

This request will create a new user in the system and return back an auth\_token back.  The auth\_token must be used for all subsequent requests (except for User Login).

**URL** /register

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
  "user": {
    "id": 3,
    "firstname": "hootan",
    "lastname": "vakili",
    "username": "hootan",
    "password_digest": "$2a$10$q/ijzziJqGiORHVnRFVmoeZ1amhJ/7pY5HAGHdnRja6q4ydmnkRPa",
    "created_at": "2015-12-02T16:11:47.314Z",
    "updated_at": "2015-12-02T16:11:47.314Z",
    "auth_token": "9dbd3e79ea32134fa2487cee124693e2",
    "email": "hootan@gmail.com"
  }
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

###<a name="user-login"></a>Login

This request will allow an existing user in the system to send their username and password and return back an auth\_token back.  The auth\_token must be used for all subsequent requests (except for User Registration).

**URL** /login

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
  "user": {
    "id": 3,
    "firstname": "hootan",
    "lastname": "vakili",
    "username": "hootan",
    "password_digest": "$2a$10$q/ijzziJqGiORHVnRFVmoeZ1amhJ/7pY5HAGHdnRja6q4ydmnkRPa",
    "created_at": "2015-12-02T16:11:47.314Z",
    "updated_at": "2015-12-02T16:11:47.314Z",
    "auth_token": "9dbd3e79ea32134fa2487cee124693e2",
    "email": "hootan@gmail.com"
  }
}   
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "error": "Could not find user for sepehr or wrong password."
}
```

###<a name="user-delete"></a>Deletion NOTE: This is currently not working

This request will allow an existing user in the system to delete their account, profile, and any posts. 

**URL** /users/:id

**Method** DELETE

**Request**
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| id | integer | ​*(Required)*​ the id of the user to be deleted |

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


###<a name="user-retrieve"></a>User Profile Retrieval

This request will allow a user to retrieve a profile of any other user as long as you provide an `Auth-Token`.

**URL** /users/:id

**Method** GET

**Request**
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| id | integer |  ​*(required)*​  the user's id whose profile you want. |

**Response**

If successful, you will receive:

    Status Code: 202 - Accepted
    
```json
{
  "profile": [
    {
      "id": 9,
      "bio": "Arrigatto!",
      "website": "http://sepehr.io",
      "location": "The Universe",
      "picture_thumb": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/009/sepehr-bali.jpg?1449025389",
      "picture_medium": "http://abstract-test.s3.amazonaws.com/profiles/medium/000/000/009/sepehr-bali.jpg?1449025389",
      "picture_large": "http://abstract-test.s3.amazonaws.com/profiles/large/000/000/009/sepehr-bali.jpg?1449025389",
      "user_id": 1,
      "username": "sepehr"
    }
  ]
}
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "errors": "Profile does not exist."
}
```

###<a name="users-retrieve"></a>All Users Profiles Retrieval

This request will allow a user to retrieve profiles of all users, paginated, as long as an `Auth-Token` is provided. Each request will provide 20 profiles at most. Providing a `page` param will allow you to get consequent profiles.

**URL** /users?page=1

**Method** GET

**Request**
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| page | integer | ​*(optional)*​ the page you want to start showing from, default is 1.  | 

**Response**

If successful, you will receive:

    Status Code: 202 - Accepted
    
```json
{
  "page": 1,
  "page_count": 1,
  "profiles": [
    {
      "id": 1,
      "bio": "Arrigatto!",
      "website": "http://sepehr.io",
      "location": "The Universe",
      "picture_thumb": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/009/sepehr-bali.jpg?1449025389",
      "picture_medium": "http://abstract-test.s3.amazonaws.com/profiles/medium/000/000/009/sepehr-bali.jpg?1449025389",
      "picture_large": "http://abstract-test.s3.amazonaws.com/profiles/large/000/000/009/sepehr-bali.jpg?1449025389",
      "profile_id": 9,
      "username": "sepehr"
    },
    {
      "id": 2,
      "bio": "Kaveh is illest of 'em all.",
      "website": "http://kaveh.io",
      "location": "Washington, DC",
      "picture_thumb": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/012/yazd.jpg?1449069611",
      "picture_medium": "http://abstract-test.s3.amazonaws.com/profiles/medium/000/000/012/yazd.jpg?1449069611",
      "picture_large": "http://abstract-test.s3.amazonaws.com/profiles/large/000/000/012/yazd.jpg?1449069611",
      "profile_id": 12,
      "username": "kaveh"
    }
  ]
}
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "error": "Could not authenticate with token: ''"
}
```

##<a name="profile-methods"></a>Profile Methods

###<a name="profile-creation"></a>Creation

This request will allow a user to create a profile immediately after signing up. 

**URL** /profiles

**Method** POST

**Request**
    
| Form Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| picture | File | ​*(Required)*​ the user's profile image |
| bio | String |  ​*(Required)*​  brief text bio of the user |
| website | String | *(Required)* user's website url |
| location | String | *(Required)* user's current location |

**Response**

If successful, you will receive:

    Status Code: 202 - Accepted
    
```json
{
  "profile": [
    {
      "id": 12,
      "bio": "Kaveh is illest of 'em all.",
      "website": "http://kaveh.io",
      "location": "Washington, DC",
      "picture_thumb": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/012/yazd.jpg?1449069611",
      "picture_medium": "http://abstract-test.s3.amazonaws.com/profiles/medium/000/000/012/yazd.jpg?1449069611",
      "picture_large": "http://abstract-test.s3.amazonaws.com/profiles/large/000/000/012/yazd.jpg?1449069611",
      "user_id": 2,
      "username": "kaveh"
    }
  ]
}
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "errors": [
    "Picture can't be blank",
    "Bio can't be blank"
  ]
}
```