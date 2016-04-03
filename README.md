# Aureso coding test

This is a simple app built on `rails-api` that exposes two endpoints accepting object slugs as params:

```
GET    /models/:model_id/model_types(.:format)
POST   /models/:model_id/model_types_price/:model_type_id(.:format)
```

Note that this is the *only* public API exposed, so before using the app, make sure to seed the database! This will create some test data as well as a test user that will be able to use the API.

## Authentication

The app uses a simple token authentication scheme (no SSL).

```
POST   /sessions(.:format)
DELETE /sessions(.:format)
```
Pass `{ user: { email: <test user email>, password: <test user password> }` in the POST request.

For further authenticated requests, pass `HTTP_X_USER_EMAIL` and `HTTP_X_AUTH_TOKEN` headers with the token body returned previously.
                  