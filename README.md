# README

## Quick usage guide

There are three entities - user, notification, and user_notification. 

To start run following:
```
docker-compose up -d 
docker-compose run app rake db:create db:migrate db:seed
```

The app should be now accesible at `localhost:3000`

### Authentication
All routes have http basic authentication. 


### Users
There are 5 basic users and 1 admin generated in the seed script. Usernames are random, 
all passwords for basic users are `muchsafeverysecret`. 
Admin credentials are:
    username:`admin` 
    pwd: `letmein` 
(`Authorization: Basic YWRtaW46bGV0bWVpbg==`)

Admin can list users at GET `/users`

### Notifications
Notification is more like a notification template (That would actually be probably better name), 
that looks like this:

```
{
    "id": 1,
    "template_text": "Hello %s, welcome to Yova!",
    "user_attributes": [
        "name"
    ]
},
```

When it is instanced for a user, all `%s` in `template_text` are replaced by
`user_attributes` which are applied to a particular user. Currently it can be only "name" or "created_at", 
but it's easily extendible.

Complete CRUD routes are available for notifications accesible only by admin users. (The typical rails routes)


### User notifications
Instance of `notification` for a particular user. Looks like this:
```
{
    "id": 1,
    "seen": true,
    "text": "Hello Mrs.DorianTreutel, welcome to Yova!",
    "user_id": 1,
    "notification_id": 1,
    "created_at": "2020-04-25T14:51:27.637Z",
    "updated_at": "2020-04-25T14:57:07.344Z"
}
```

The text isn't stored in db, but is rendered from the template and user attributes.

User notifications routes:

 - GET `/my_notifications` - list of notifications for current user
 - GET `/user_notifications` - route accesible by admins for filtering user notifications. Filtering is done by url params  (i.e. `/localhost:3000/user_notifications?seen=true&sort_by=created_at`) Possible params:
    - seen
    - user_ids - list of ids separated by commas
    - sort_by - user attribute by which to sort
    - sort_order - asc or desc
    - limit
 - POST `user_notifications/<id>/seen` - marks notification as seen - the user notification has to belong to the current authenticated user
 - POST `user_notifications?user_id=<user_id>&notification_id=<notification_id>` - Creates instance of notification for particular user