# Instructor: Deployment

## Why is there a "Platforms" section in the deployment lessno?

- Heroku is a Platform as a Service
- This is an introduction to other platforms students will likely use in Capstone

## What is Heroku?

I actually like [Heroku's introduction video for "What is Heroku and why do we use it?"](https://youtu.be/_N8Zf_nPZkQ)

- This video names a bunch of topics, features, etc that is COMPLETELY out of scope for this curriculum, and students (and maybe you!) will be like "What is this?!?!?!!"
  - That's great!
  - That's infrastructure, babyeeeee
- This video mostly gets to its point by saying "This is all the stuff you'd have to do without Heroku"
  - TLDR if we didn't have Heroku, in order to deploy and manage our web apps, we'd need to learn how to do plumbing

## Procfile

It's super not important to know what the code in the Procfile does, UNLESS you happen to change how the app is configured.

Given this Procfile:

```
web: gunicorn 'app:create_app()'
```

This says that there's a Heroku _web_ process. The process named "web" is a special one that determines how Heroku runs the web servers.

`gunicorn` is a package to help with running web servers.

`'app:create_app()'` means that we're looking for the `app` module, and the app object we need is the result of the `create_app()` function inside the module.

If we moved our `create_app()` function or changed the name of the module, we would need to change this Procfile.
