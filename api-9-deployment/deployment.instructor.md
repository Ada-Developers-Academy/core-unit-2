# Instructor: Deployment

Flask is weird about `/`. In "Building an API"/"Create and Read" we have a tip about loosening the routing pattern so that "" and "/" routes do the same thing.

Sorry y'all I took out the direct link to that lesson </3 hehehe lolol.

## Why is there a "Platforms" section in the deployment lesson?

- Heroku is a Platform as a Service
- This is an introduction to other platforms students will likely use in Capstone


## Gunicorn Start Coomand

It's super not important to know what the command does, UNLESS you happen to change how the app is configured.


```
 gunicorn 'app:create_app()'
```

This command says that `gunicorn` is a package to help with running web servers.

`'app:create_app()'` means that we're looking for the `app` module, and the app object we need is the result of the `create_app()` function inside the module.

If we moved our `create_app()` function or changed the name of the module, we would need to change this Procfile.

## Altering the External Connection String
We need to change the external connection string slightly when we use it because [the postgres dialect is no longer supported by SQLAlchemy 1.4](https://github.com/sqlalchemy/sqlalchemy/blob/8fc5005dfe3eb66a46470ad8a8c7b95fc4d6bdca/lib/sqlalchemy/dialects/postgres.py).