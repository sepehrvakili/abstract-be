# Abstract App API :: O__O
<hr>

Welcome to the Abstract App API documentation. Abstract allows creators to inspire and to be inspired!

The url params are called Path parameters

**Methods**

* [User Methods](#user-methods)
  * [Registration](#user-registration)
  * [Login] (#user-login)
  * [Delete] (#user-delete)
  * [Retrieve One Profile] (#user-retrieve)
  * [Retrieve All Profiles] (#user-retrieve-all)

* [Profile Methods] (#profile-methods)
  * [Create] (#profile-creation)

* [Post Methods](#post-methods)
  * [Create](#post-creation)
  * [Retrieve](#post-retrieve)
  * [Update](#post-update)
  * [Delete](#post-delete)
  * [Retrieve All Posts](#post-retrieve-all)

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

###<a name="user-delete"></a>Delete User NOTE: This is currently not working

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


###<a name="user-retrieve"></a>Retrieve One Profile

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

###<a name="users-retrieve-all"></a>Retrieve All Profiles

This request will allow a user to retrieve profiles of all users, paginated, as long as an `Auth-Token` is provided. Each request will provide 20 profiles at most. Providing a `page` param will allow you to get consequent profiles. For first 20 users `page` can be empty since default value is `1`. For second 20 users (eg. users 21-40) `page` should be `2` and so on.

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

###<a name="profile-create"></a>Create

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
  "error": "Could not authenticate with token: '89a9b31ad1bd2a5c7e2010b29dbc31a2f'"
}
```

##<a name="post-methods"></a>Post Methods

###<a name="post-create"></a>Create

There are currently 4 post types including: `image`, `text`, `link`, `quote`.
When a user creates a new post the must select one of these four post types.
This should be a dropdown field that is populated by the front-end app.

This request will allow a user to create a post immediately after signing up. 

**URL** /users/:user_id/posts

**Method** POST

**Request**
    
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| user_id | integer | ​*(Required)*​ the id of the user creating the post |

**Note**

Given that there is one Post model all fields are optional except `post_type`.
However, the front-end app can perform validation to ensure all fields relavent to a selected post type are provided.

| Form Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| post_type | string | ​*(Required)*​ the type of the post being created |
| title | string |  ​*(Optional)*​  should be provided if user is creating `post_type` `image` |
| status | string | *(Optional)*​ should be provided if user is creating `post_type` `text` |
| url | string | *(Optional)* should be provided if user is creating `post_type` `link` |
| description | String | *(Optional)* should be provided if user is creating `post_type` `link` or `image` |
| quote | string | *(Optional)* should be provided if user is creating `post_type` `quote` |

**Response**

If successful, you will receive:

    Status Code: 202 - Accepted

```json
{
  "post": [
    {
      "id": 1,
      "post_type": "image",
      "title": "The Beach",
      "url": null,
      "description": "Hello Beach",
      "status": null,
      "quote": null,
      "image_thumb": "http://abstract-prod.s3.amazonaws.com/posts/thumb/000/000/001/524035_4527286665178_246125113_n.jpg?1449077310",
      "image_medium": "http://abstract-prod.s3.amazonaws.com/posts/medium/000/000/001/524035_4527286665178_246125113_n.jpg?1449077310",
      "image_large": "http://abstract-prod.s3.amazonaws.com/posts/large/000/000/001/524035_4527286665178_246125113_n.jpg?1449077310",
      "username": "sepehr",
      "created_at": "2015-12-02T17:28:31.506Z",
      "updated_at": "2015-12-02T17:28:31.506Z"
    }
  ]
}
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "error": "Could not authenticate with token: '89a9bad1bd2a5c7e2010b29dbc31a2f'"
}
```

###<a name="post-retrieve"></a>Retrieve

**URL** /users/:user_id/posts/:id

**Method** GET

**Request**
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| user_id | integer | ​*(Required)*​ the id of the user whose post you're retrieving |
| id | integer | ​*(Required)*​ the id of the post you're retrieving |

**Response**

If successful, you will receive:

    Status Code: 202 - Accepted

```json
{
  "post": [
    {
      "id": 1,
      "post_type": "image",
      "title": "The Beach",
      "url": null,
      "description": "Hello Beach",
      "status": null,
      "quote": null,
      "image_thumb": "http://abstract-prod.s3.amazonaws.com/posts/thumb/000/000/001/524035_4527286665178_246125113_n.jpg?1449077310",
      "image_medium": "http://abstract-prod.s3.amazonaws.com/posts/medium/000/000/001/524035_4527286665178_246125113_n.jpg?1449077310",
      "image_large": "http://abstract-prod.s3.amazonaws.com/posts/large/000/000/001/524035_4527286665178_246125113_n.jpg?1449077310",
      "username": "sepehr",
      "created_at": "2015-12-02T17:28:31.506Z",
      "updated_at": "2015-12-02T17:28:31.506Z"
    }
  ]
}
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "error": "Could not authenticate with token: '89a9bad1bd2a5c7e2010b29dbc31a2f'"
}
```

###<a name="post-update"></a>Update

**URL** /users/:user_id/posts/:id

**Method** PUT

**Request**
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| user_id | integer | ​*(Required)*​ the id of the user whose post you're retrieving |
| id | integer | ​*(Required)*​ the id of the post you're retrieving |

**Note**

Given that there is one Post model all fields are optional except `post_type`.
However, the front-end app can perform validation to ensure all fields relavent to a selected post type are provided.

| Form Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| title | string |  ​*(Optional)*​  should be provided if user is creating `post_type` `image` |
| status | string | *(Optional)*​ should be provided if user is creating `post_type` `text` |
| url | string | *(Optional)* should be provided if user is creating `post_type` `link` |
| description | String | *(Optional)* should be provided if user is creating `post_type` `link` or `image` |
| quote | string | *(Optional)* should be provided if user is creating `post_type` `quote` |

**Response**

If successful, you will receive:

    Status Code: 200 - OK

```json
{
  "post": [
    {
      "id": 1,
      "post_type": "image",
      "title": "The Beach",
      "url": null,
      "description": "Hello Beach",
      "status": null,
      "quote": null,
      "image_thumb": "http://abstract-prod.s3.amazonaws.com/posts/thumb/000/000/001/524035_4527286665178_246125113_n.jpg?1449077310",
      "image_medium": "http://abstract-prod.s3.amazonaws.com/posts/medium/000/000/001/524035_4527286665178_246125113_n.jpg?1449077310",
      "image_large": "http://abstract-prod.s3.amazonaws.com/posts/large/000/000/001/524035_4527286665178_246125113_n.jpg?1449077310",
      "username": "sepehr",
      "created_at": "2015-12-02T17:28:31.506Z",
      "updated_at": "2015-12-02T17:28:31.506Z"
    }
  ]
}
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "error": "Could not authenticate with token: '89a9bad1bd2a5c7e2010b29dbc31a2f'"
}
```

###<a name="post-delete"></a>Delete

**URL** /users/:user_id/posts/:id

**Method** DELETE

**Request**
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| user_id | integer | ​*(Required)*​ the id of the user whose post you're retrieving |
| id | integer | ​*(Required)*​ the id of the post you're retrieving |

**Response**

If successful, you will receive:

    Status Code: 200 - OK

```json
{
  "message": "My new post has been deleted."
}
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "message": "User Amit does not have access to this post."
}
```

###<a name="post-retrieve-all"></a>Retrieve All Posts

**URL** /users/:user_id/posts

**Method** GET

**Request**
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| user_id | integer | ​*(Required)*​ the id of the user whose post you're retrieving |

**Response**

If successful, you will receive:

    Status Code: 200 - OK

```json
{
  "page": 1,
  "page_count": 1,
  "posts": [
    {
      "id": 7,
      "post_type": "image",
      "title": "My new postff",
      "url": null,
      "description": "Hello Beach",
      "status": null,
      "quote": null,
      "image_thumb": "http://abstract-prod.s3.amazonaws.com/posts/thumb/000/000/007/juara_beach.jpg?1449085301",
      "image_medium": "http://abstract-prod.s3.amazonaws.com/posts/medium/000/000/007/juara_beach.jpg?1449085301",
      "image_large": "http://abstract-prod.s3.amazonaws.com/posts/large/000/000/007/juara_beach.jpg?1449085301",
      "username": "hootan",
      "created_at": "2015-12-02T19:41:42.086Z",
      "updated_at": "2015-12-02T19:41:42.086Z"
    },
    {
      "id": 6,
      "post_type": "image",
      "title": "My new post3",
      "url": null,
      "description": "Hello Beach",
      "status": null,
      "quote": null,
      "image_thumb": "http://abstract-prod.s3.amazonaws.com/posts/thumb/000/000/006/juara_beach.jpg?1449085294",
      "image_medium": "http://abstract-prod.s3.amazonaws.com/posts/medium/000/000/006/juara_beach.jpg?1449085294",
      "image_large": "http://abstract-prod.s3.amazonaws.com/posts/large/000/000/006/juara_beach.jpg?1449085294",
      "username": "hootan",
      "created_at": "2015-12-02T19:41:34.861Z",
      "updated_at": "2015-12-02T19:41:34.861Z"
    },
    {
      "id": 3,
      "post_type": "image",
      "title": "My new post",
      "url": null,
      "description": "Hello Beach",
      "status": null,
      "quote": null,
      "image_thumb": "http://abstract-prod.s3.amazonaws.com/posts/thumb/000/000/003/juara_beach.jpg?1449084873",
      "image_medium": "http://abstract-prod.s3.amazonaws.com/posts/medium/000/000/003/juara_beach.jpg?1449084873",
      "image_large": "http://abstract-prod.s3.amazonaws.com/posts/large/000/000/003/juara_beach.jpg?1449084873",
      "username": "hootan",
      "created_at": "2015-12-02T19:34:33.376Z",
      "updated_at": "2015-12-02T19:34:33.376Z"
    }
  ]
}
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "error": "Could not authenticate with token: '89a9bad1bd2a5c7e2010b29dbc31a2f'"
}
```



o____o


