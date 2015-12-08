# Abstract App API :: O__O
<hr>

Welcome to the Abstract App API documentation. Abstract allows creators to inspire and to be inspired!

The url params are called Path parameters

**Methods**

* [User Methods](#user-methods)
  * [Registration](#user-registration)
  * [Login](#user-login)
  * [Delete](#user-delete)
  * [Retrieve One Profile](#user-retrieve)
  * [Retrieve All Profiles](#user-retrieve-all)

* [Profile Methods](#profile-methods)
  * [Create](#profile-create)

* [Post Methods](#post-methods)
  * [Create](#post-creation)
  * [Retrieve A Specific Post](#post-retrieve)
  * [Retrieve All Posts for A User](#post-retrieve-all-per-user)
  * [Retrieve All Posts on the Site](#post-retrieve-all)
  * [Update](#post-update)
  * [Delete](#post-delete)

* [Comment Methods](#comment-methods)
  * [Create](#comment-create)
  * [Retrieve a Specific Comment](#comment-retrieve)
  * [Retrieve Comments for A Post](#comments-retrieve)
  * [Update](#comment-update)
  * [Delete](#comment-delete)

* [Like Methods](#like-methods)
  * [Create](#like-create)
  * [Retrieve](#like-retrieve)
  * [Delete](#like-delete)


##<a name="user-methods"></a>User Methods

###<a name="user-registeration"></a>Registration

This request will create a new user in the system and return back an auth\_token back.  The auth\_token must be used for all subsequent requests (except for User Login).

**URL** /register

**Method** POST

**Request**
    

| Form Params | Type           | Description  |
| ------------- |:-------------:|:----- |
| firstname | String | *(required)* User's first name
| lastname | String | *(required)* User's last name
| username | String | *(required)* User's username
| email | String | ​*(required)*​ Users email address, must follow the format text@text.text |
| password    | String      |  ​*(required)*​  password for the user |


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
| username | String | ​*(required)*​ existing user's username |
| password | String |  ​*(required)*​  password for the user |


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
| id | integer | ​*(required)*​ the id of the user to be deleted |

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
| picture | File | ​*(required)*​ the user's profile image |
| bio | String |  ​*(required)*​  brief text bio of the user |
| website | String | *(required)* user's website url |
| location | String | *(required)* user's current location |
| tag_phrases | string | *(optional)* optional field, must return comma separated words |

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

There are currently 4 post types including: `image`, `text`, `link`, `quote`, or `moodboard`.
When a user creates a new post the must select one of these four post types.
This should be a dropdown field that is populated by the front-end app.

This request will allow a user to create a post immediately after signing up. 

**URL** /posts

**Method** POST

**Request**

Given that there is one Post model all fields are optional except `post_type`.
However, the front-end app can perform validation to ensure all fields relavent to a selected post type are provided.

| Form Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| post_type | string | ​*(required)*​ the type of post being created |
| image | file |  ​*(optional)*​  should be provided if user is creating `post_type` `image` |
| title | string |  ​*(optional)*​  should be provided if user is creating `post_type` `image` |
| status | string | *(optional)*​ should be provided if user is creating `post_type` `text` |
| url | string | *(optional)* should be provided if user is creating `post_type` `link` |
| description | String | *(optional)* should be provided if user is creating `post_type` `link` or `image` |
| quote | string | *(optional)* should be provided if user is creating `post_type` `quote` |
| tag_phrases | string | *(optional)* optional field, must return comma separated words |

**Response**

If successful, you will receive:

    Status Code: 202 - Accepted

```json
{
  "post": {
    "id": 24,
    "post_type": "image",
    "moodboard_css_class": null,
    "title": "Travel Photo",
    "url": null,
    "description": null,
    "status": null,
    "quote": null,
    "image_thumb": "http://abstract-test.s3.amazonaws.com/posts/thumb/000/000/024/gorgan_road.jpg?1449612321",
    "image_medium": "http://abstract-test.s3.amazonaws.com/posts/medium/000/000/024/gorgan_road.jpg?1449612321",
    "image_large": "http://abstract-test.s3.amazonaws.com/posts/large/000/000/024/gorgan_road.jpg?1449612321",
    "user_id": 4,
    "username": "kiarash",
    "likes_count": 0,
    "tags": "gorgan, iran, travel",
    "created_at": "2015-12-08T22:05:22.416Z",
    "updated_at": "2015-12-08T22:05:22.416Z",
    "moodpieces": []
  }
}
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "error": "Could not authenticate with token: '89a9bad1bd2a5c7e2010b29dbc31a2f'"
}
```

###<a name="post-retrieve"></a>Retrieve A Specific Post

**URL** /posts/:id

**Method** GET

**Request**
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| id | integer | ​*(required)*​ the id of the post you're retrieving |

**Response**

If successful, you will receive:

    Status Code: 202 - Accepted

```json
{
  "post": {
    "id": 20,
    "post_type": "moodboard",
    "moodboard_css_class": "template1",
    "moodpieces": [
      {
        "id": 1,
        "div_id": "position1",
        "color": null,
        "image": "http://abstract-test.s3.amazonaws.com/moodpieces/original/000/000/001/gorgan_road.jpg?1449602063"
      },
      {
        "id": 2,
        "div_id": "position1",
        "color": null,
        "image": "http://abstract-test.s3.amazonaws.com/moodpieces/original/000/000/002/gorgan_road.jpg?1449602189"
      },
      {
        "id": 3,
        "div_id": "position3",
        "color": null,
        "image": "http://abstract-test.s3.amazonaws.com/moodpieces/original/000/000/003/gorgan_road.jpg?1449602459"
      }
    ],
    "title": "This is a moodboard post.",
    "url": null,
    "description": null,
    "status": null,
    "quote": null,
    "image_thumb": "/images/thumb/missing.png",
    "image_medium": "/images/medium/missing.png",
    "image_large": "/images/large/missing.png",
    "user_id": 4,
    "username": "kiarash",
    "likes_count": 0,
    "tags": "apple, bannanaa, moodboard, banana!!!",
    "created_at": "2015-12-08T19:05:19.063Z",
    "updated_at": "2015-12-08T19:05:19.063Z",
    "comments": [
      {
        "id": 10,
        "message": "hellow comment ",
        "created_at": "2015-12-08T21:20:51.524Z",
        "updated_at": "2015-12-08T21:20:51.524Z",
        "user_id": 2,
        "username": "kaveh",
        "picture": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/012/yazd.jpg?1449069611"
      },
      {
        "id": 11,
        "message": "hellow comment@@@111 ",
        "created_at": "2015-12-08T21:21:08.794Z",
        "updated_at": "2015-12-08T21:21:08.794Z",
        "user_id": 2,
        "username": "kaveh",
        "picture": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/012/yazd.jpg?1449069611"
      }
    ]
  }
}
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "error": "Could not authenticate with token: '89a9bad1bd2a5c7e2010b29dbc31a2f'"
}
```

###<a name="post-retrieve-all-per-user"></a>Retrieve All Posts For a User

**URL** /users/:user_id/posts?page=1

**Method** GET

**Request**
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| user_id | integer | ​*(required)*​ the id of the user whose post you're retrieving |
| page | integer | ​*(optional)*​ the page you want to start showing from, default is 1.  | 

**Response**

If successful, you will receive:

    Status Code: 202 - Accepted

```json
{
  "page": 1,
  "page_count": 1,
  "posts": [
    {
      "post": {
        "id": 21,
        "post_type": "moodboard",
        "title": "This is a moodboard post.",
        "url": null,
        "description": null,
        "status": null,
        "quote": null,
        "image_thumb": "/images/thumb/missing.png",
        "image_medium": "/images/medium/missing.png",
        "image_large": "/images/large/missing.png",
        "user_id": 4,
        "username": "kiarash",
        "likes_count": 0,
        "tags": "apple, bannanaa, moodboard, banana!!!",
        "created_at": "2015-12-08T21:38:58.638Z",
        "updated_at": "2015-12-08T21:38:58.638Z",
        "moodboard_css_class": "template1",
        "moodpieces": [],
        "comments": []
      }
    },
    {
      "post": {
        "id": 20,
        "post_type": "moodboard",
        "title": "This is a moodboard post.",
        "url": null,
        "description": null,
        "status": null,
        "quote": null,
        "image_thumb": "/images/thumb/missing.png",
        "image_medium": "/images/medium/missing.png",
        "image_large": "/images/large/missing.png",
        "user_id": 4,
        "username": "kiarash",
        "likes_count": 0,
        "tags": "apple, bannanaa, moodboard, banana!!!",
        "created_at": "2015-12-08T19:05:19.063Z",
        "updated_at": "2015-12-08T19:05:19.063Z",
        "moodboard_css_class": "template1",
        "moodpieces": [
          {
            "id": 1,
            "div_id": "position1",
            "color": null,
            "image": "http://abstract-test.s3.amazonaws.com/moodpieces/original/000/000/001/gorgan_road.jpg?1449602063"
          },
          {
            "id": 2,
            "div_id": "position1",
            "color": null,
            "image": "http://abstract-test.s3.amazonaws.com/moodpieces/original/000/000/002/gorgan_road.jpg?1449602189"
          },
          {
            "id": 3,
            "div_id": "position3",
            "color": null,
            "image": "http://abstract-test.s3.amazonaws.com/moodpieces/original/000/000/003/gorgan_road.jpg?1449602459"
          }
        ],
        "comments": [
          {
            "id": 10,
            "message": "hellow comment ",
            "created_at": "2015-12-08T21:20:51.524Z",
            "updated_at": "2015-12-08T21:20:51.524Z",
            "user_id": 2,
            "username": "kaveh",
            "picture": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/012/yazd.jpg?1449069611"
          },
          {
            "id": 11,
            "message": "hellow comment@@@111 ",
            "created_at": "2015-12-08T21:21:08.794Z",
            "updated_at": "2015-12-08T21:21:08.794Z",
            "user_id": 2,
            "username": "kaveh",
            "picture": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/012/yazd.jpg?1449069611"
          }
        ]
      }
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

###<a name="post-retrieve-all"></a>Retrieve All Posts on the Site

**URL** /posts?page=1

**Method** GET

**Request**
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| page | integer | ​*(optional)*​ the page you want to start showing from, default is 1.  | 

**Response**

If successful, you will receive:

    Status Code: 200 - OK

```json
{
  "page": 1,
  "page_count": 1,
  "posts": [
    {
      "post": {
        "id": 21,
        "post_type": "moodboard",
        "title": "This is a moodboard post.",
        "url": null,
        "description": null,
        "status": null,
        "quote": null,
        "image_thumb": "/images/thumb/missing.png",
        "image_medium": "/images/medium/missing.png",
        "image_large": "/images/large/missing.png",
        "user_id": 4,
        "username": "kiarash",
        "likes_count": 0,
        "tags": "apple, bannanaa, moodboard, banana!!!",
        "created_at": "2015-12-08T21:38:58.638Z",
        "updated_at": "2015-12-08T21:38:58.638Z",
        "moodboard_css_class": "template1",
        "moodpieces": [],
        "comments": []
      }
    },
    {
      "post": {
        "id": 20,
        "post_type": "moodboard",
        "title": "This is a moodboard post.",
        "url": null,
        "description": null,
        "status": null,
        "quote": null,
        "image_thumb": "/images/thumb/missing.png",
        "image_medium": "/images/medium/missing.png",
        "image_large": "/images/large/missing.png",
        "user_id": 4,
        "username": "kiarash",
        "likes_count": 0,
        "tags": "apple, bannanaa, moodboard, banana!!!",
        "created_at": "2015-12-08T19:05:19.063Z",
        "updated_at": "2015-12-08T19:05:19.063Z",
        "moodboard_css_class": "template1",
        "moodpieces": [
          {
            "id": 1,
            "div_id": "position1",
            "color": null,
            "image": "http://abstract-test.s3.amazonaws.com/moodpieces/original/000/000/001/gorgan_road.jpg?1449602063"
          },
          {
            "id": 2,
            "div_id": "position1",
            "color": null,
            "image": "http://abstract-test.s3.amazonaws.com/moodpieces/original/000/000/002/gorgan_road.jpg?1449602189"
          },
          {
            "id": 3,
            "div_id": "position3",
            "color": null,
            "image": "http://abstract-test.s3.amazonaws.com/moodpieces/original/000/000/003/gorgan_road.jpg?1449602459"
          }
        ],
        "comments": [
          {
            "id": 10,
            "message": "hellow comment ",
            "created_at": "2015-12-08T21:20:51.524Z",
            "updated_at": "2015-12-08T21:20:51.524Z",
            "user_id": 2,
            "username": "kaveh",
            "picture": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/012/yazd.jpg?1449069611"
          },
          {
            "id": 11,
            "message": "hellow comment@@@111 ",
            "created_at": "2015-12-08T21:21:08.794Z",
            "updated_at": "2015-12-08T21:21:08.794Z",
            "user_id": 2,
            "username": "kaveh",
            "picture": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/012/yazd.jpg?1449069611"
          }
        ]
      }
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

**URL** /posts/:id

**Method** PUT

**Request**
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| id | integer | ​*(required)*​ the id of the post you're updating |

**Note**

Given that there is one Post model all fields are optional except `post_type`.
However, the front-end app can perform validation to ensure all fields relavent to a selected post type are provided.

| Form Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| post_type | string | ​*(required)*​ the type of the post being created |
| image | file |  ​*(optional)*​  should be provided if user is creating `post_type` `image` |
| title | string |  ​*(optional)*​  should be provided if user is creating `post_type` `image` |
| status | string | *(optional)*​ should be provided if user is creating `post_type` `text` |
| url | string | *(optional)* should be provided if user is creating `post_type` `link` |
| description | string | *(optional)* should be provided if user is creating `post_type` `link` or `image` |
| quote | string | *(optional)* should be provided if user is creating `post_type` `quote` |
| tag_phrases | string | *(optional)* optional field, must return comma separated words |

**Response**

If successful, you will receive:

    Status Code: 200 - OK

```json
{
  "post": {
    "id": 20,
    "post_type": "moodboard",
    "moodboard_css_class": "template1",
    "title": "Travel Photo",
    "url": null,
    "description": null,
    "status": null,
    "quote": null,
    "image_thumb": "/images/thumb/missing.png",
    "image_medium": "/images/medium/missing.png",
    "image_large": "/images/large/missing.png",
    "user_id": 4,
    "username": "kiarash",
    "likes_count": 0,
    "tags": "gorgan, iran, travel, nature",
    "created_at": "2015-12-08T19:05:19.063Z",
    "updated_at": "2015-12-08T22:08:29.801Z",
    "moodpieces": [
      {
        "id": 1,
        "div_id": "position1",
        "color": null,
        "image": "http://abstract-test.s3.amazonaws.com/moodpieces/original/000/000/001/gorgan_road.jpg?1449602063"
      },
      {
        "id": 2,
        "div_id": "position1",
        "color": null,
        "image": "http://abstract-test.s3.amazonaws.com/moodpieces/original/000/000/002/gorgan_road.jpg?1449602189"
      },
      {
        "id": 3,
        "div_id": "position3",
        "color": null,
        "image": "http://abstract-test.s3.amazonaws.com/moodpieces/original/000/000/003/gorgan_road.jpg?1449602459"
      }
    ],
    "comments": [
      {
        "id": 10,
        "message": "hellow comment ",
        "created_at": "2015-12-08T21:20:51.524Z",
        "updated_at": "2015-12-08T21:20:51.524Z",
        "user_id": 2,
        "username": "kaveh",
        "picture": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/012/yazd.jpg?1449069611"
      },
      {
        "id": 11,
        "message": "hellow comment@@@111 ",
        "created_at": "2015-12-08T21:21:08.794Z",
        "updated_at": "2015-12-08T21:21:08.794Z",
        "user_id": 2,
        "username": "kaveh",
        "picture": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/012/yazd.jpg?1449069611"
      }
    ]
  }
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

**URL** /posts/:id

**Method** DELETE

**Request**
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| user_id | integer | ​*(required)*​ the id of the user whose post you're retrieving |
| id | integer | ​*(required)*​ the id of the post you're retrieving |

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

##<a name="comment-methods"></a>Comment Methods

###<a name="comment-create"></a>Create

This request will allow a user to create a comment. 

**URL** /posts/:post_id/comments

**Method** POST

**Request**

| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| post_id | integer | ​*(required)*​ the id of the post being commented on |

| Form Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| message | string | ​*(required)*​ the comment message being left |

**Response**

If successful, you will receive:

    Status Code: 200 - OK

```json
{
  "comment": {
    "id": 4,
    "message": "hello comment today here now!",
    "commentable_id": 5,
    "commentable_type": "Post",
    "created_at": "2015-12-06T17:05:20.597Z",
    "updated_at": "2015-12-07T16:47:42.990Z",
    "user_id": 4
  }
}
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "message": "User Amit does not have access to this post."
}
```

###<a name="comment-retrieve"></a>Retrieve a Specific Comment

This request will allow you to retrieve a comment with its `id`. 

**URL** /posts/:post_id/comments/:id

**Method** GET

**Request**

| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| post_id | integer | ​*(required)*​ the id of the post being commented on |
| id | integer | ​*(required)*​ the id of the comment |

**Response**

If successful, you will receive:

    Status Code: 200 - OK

```json
{
  "comments": [
    {
      "id": 4,
      "message": "hello comment today here now!",
      "commentable_id": 5,
      "commentable_type": "Post",
      "created_at": "2015-12-06T17:05:20.597Z",
      "updated_at": "2015-12-07T16:47:42.990Z",
      "user_id": 4
    },
    {
      "id": 8,
      "message": "hello world",
      "commentable_id": 5,
      "commentable_type": "Post",
      "created_at": "2015-12-07T19:11:15.366Z",
      "updated_at": "2015-12-07T19:11:15.366Z",
      "user_id": 4
    },
    {
      "id": 9,
      "message": "hello world11",
      "commentable_id": 5,
      "commentable_type": "Post",
      "created_at": "2015-12-07T19:14:05.692Z",
      "updated_at": "2015-12-07T19:14:05.692Z",
      "user_id": 4
    }
  ]
}
```

###<a name="comments-retrieve"></a>Retrieve Comments for a Post

This request will allow you to retrieve a comment with its `id`. 

**URL** /posts/:post_id/comments

**Method** GET

**Request**

| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| post_id | integer | ​*(required)*​ the id of the post being commented on |

**Response**

If successful, you will receive:

    Status Code: 200 - OK

```json
{
  "comments": [
    {
      "id": 4,
      "message": "hello comment today here now!",
      "commentable_id": 5,
      "commentable_type": "Post",
      "created_at": "2015-12-06T17:05:20.597Z",
      "updated_at": "2015-12-07T16:47:42.990Z",
      "user_id": 4
    },
    {
      "id": 8,
      "message": "hello world",
      "commentable_id": 5,
      "commentable_type": "Post",
      "created_at": "2015-12-07T19:11:15.366Z",
      "updated_at": "2015-12-07T19:11:15.366Z",
      "user_id": 4
    },
    {
      "id": 9,
      "message": "hello world11",
      "commentable_id": 5,
      "commentable_type": "Post",
      "created_at": "2015-12-07T19:14:05.692Z",
      "updated_at": "2015-12-07T19:14:05.692Z",
      "user_id": 4
    }
  ]
}
```

###<a name="comment-delete"></a>Delete

**URL** /posts/:post_id/comments/:id

**Method** DELETE

**Request**
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| post_id | integer | ​*(required)*​ the id of the post being commented on  |
| id | integer | ​*(required)*​ the id of the comment |

**Response**

If successful, you will receive:

    Status Code: 200 - OK

```json
{
  "message": "Comment has been deleted."
}
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "message": "User Amit does not have access to this comment."
}
```

##<a name="like-methods"></a>Like Methods

###<a name="like-create"></a>Create

This request will allow a user to like anything likeable, eg. Post, Discussion, etc. 

**URL** /posts/:post_id/likes

**Method** POST

**Request**

| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| post_id | integer | ​*(required)*​ the id of the post being liked |

**Response**

If successful, you will receive:

    Status Code: 200 - OK

```json
{
  "message": "Item has been liked."
}
```

If unsuccessful, you will receive:

    Status Code: 500 - Internal Server Error
    
```json
{
  "errors": [
    "User can only like an item once."
  ]
}
```

###<a name="like-retrieve"></a>Retrieve A User's Likes

This request will allow you to retrieve all likeables of a specified type that a user has liked. 

**URL** /users/:user_id/likes?likeable_type=post

**Method** GET

**Request**

| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| user_id | integer | ​*(required)*​ the id of the user whose likes you want |
| likeable_type | string | ​*(required)*​ the type of likeable, eg. post |

**Response**

If successful, you will receive:

    Status Code: 200 - OK

```json
{
  "page": "1",
  "page_count": 1,
  "likes": [
    {
      "like": {
        "id": 5,
        "post_type": "text",
        "title": "Multi words This is polymorphic by sepehr",
        "url": null,
        "description": "Hello World",
        "status": "what done happen was is that...",
        "quote": null,
        "image_thumb": "http://abstract-test.s3.amazonaws.com/posts/thumb/000/000/005/sepehr-bali.jpg?1449017810",
        "image_medium": "http://abstract-test.s3.amazonaws.com/posts/medium/000/000/005/sepehr-bali.jpg?1449017810",
        "image_large": "http://abstract-test.s3.amazonaws.com/posts/large/000/000/005/sepehr-bali.jpg?1449017810",
        "user_id": 1,
        "username": "sepehr",
        "likes_count": 1,
        "tags": "atlanta, polymorphic, multiple words phrase",
        "created_at": "2015-12-02T00:56:50.659Z",
        "updated_at": "2015-12-03T20:51:30.630Z",
        "moodboard_css_class": null,
        "moodpieces": [],
        "comments": [
          {
            "id": 4,
            "message": "hello comment today here now!",
            "created_at": "2015-12-06T17:05:20.597Z",
            "updated_at": "2015-12-07T16:47:42.990Z",
            "user_id": 4,
            "username": "kiarash",
            "picture": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/015/Screen_Shot_2015-12-02_at_10.38.51_PM.png?1449176752"
          },
          {
            "id": 8,
            "message": "hello world",
            "created_at": "2015-12-07T19:11:15.366Z",
            "updated_at": "2015-12-07T19:11:15.366Z",
            "user_id": 4,
            "username": "kiarash",
            "picture": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/015/Screen_Shot_2015-12-02_at_10.38.51_PM.png?1449176752"
          },
          {
            "id": 9,
            "message": "hello world11",
            "created_at": "2015-12-07T19:14:05.692Z",
            "updated_at": "2015-12-07T19:14:05.692Z",
            "user_id": 4,
            "username": "kiarash",
            "picture": "http://abstract-test.s3.amazonaws.com/profiles/thumb/000/000/015/Screen_Shot_2015-12-02_at_10.38.51_PM.png?1449176752"
          }
        ]
      }
    },
    {
      "like": {
        "id": 19,
        "post_type": "text",
        "title": "This is a new post by Kaveh",
        "url": null,
        "description": null,
        "status": null,
        "quote": "This post has a quote!",
        "image_thumb": "/images/thumb/missing.png",
        "image_medium": "/images/medium/missing.png",
        "image_large": "/images/large/missing.png",
        "user_id": 4,
        "username": "kiarash",
        "likes_count": 2,
        "tags": "apple, bannanaa",
        "created_at": "2015-12-08T03:32:36.962Z",
        "updated_at": "2015-12-08T03:32:36.962Z",
        "moodboard_css_class": null,
        "moodpieces": [],
        "comments": []
      }
    }
  ]
}
```

If unsuccessful, you will receive:

    Status Code: 500 - Internal Server Error
    
```json
{
  "errors": "You must provide a likeable_type path param."
}
```

###<a name="like-delete"></a>Delete

**URL** /posts/:post_id/likes

**Method** DELETE

**Request**
    
| Path Params       | Type           | Description  |
| ------------- |:-------------:|:----- |
| post_id | integer | ​*(required)*​ the id of the post being commented on  |

**Response**

If successful, you will receive:

    Status Code: 200 - OK

```json
{
  "message": "Amit's like has been removed."
}
```

If unsuccessful, you will receive:

    Status Code: 401 - Not Authorized
    
```json
{
  "error": "Could not authenticate with token: '9dbd3e79ea32134fa2487cee2f'"
}
```


o____o


