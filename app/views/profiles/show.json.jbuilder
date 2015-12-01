json.bio @profile.bio
json.website @profile.website
json.location @profile.location
json.picture_thumb @profile.picture.url(:thumb)
json.picture_medium @profile.picture.url(:medium)
json.picture_large @profile.picture.url(:large)